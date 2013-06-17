# encoding: utf-8

module ConstructorPages
  class TemplatesController < ConstructorCore::ApplicationController
    include MoveHelper

    before_filter {@roots = Template.roots}

    def new
      @template = Template.new

      if params[:template]
        @parent = Template.find(params[:template])
        @template.parent_id = @parent.id
      end
    end

    def edit
      @template = Template.find(params[:id])
    end

    def create
      @template = Template.new params[:template]

      if @template.save
        redirect_to templates_url, notice: t(:template_success_added, name: @template.name)
      else
        render action: :new
      end
    end

    def update
      @template = Template.find params[:id]

      if @template.update_attributes params[:template]
        redirect_to templates_url, notice: t(:template_success_updated, name: @template.name)
      else
        render action: :edit
      end
    end

    def destroy
      @template = Template.find(params[:id])
      name = @template.name
      @template.destroy
      redirect_to templates_url, notice: t(:template_success_removed, name: name)
    end

    %w{up down}.each {|m| define_method "move_#{m}" do move_to :template, m.to_sym end}
  end
end
