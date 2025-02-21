module ProjectsHelper
  def status_color_classes
    {
      'pending' => 'bg-yellow-100 text-yellow-800',
      'active' => 'bg-green-100 text-green-800',
      'complete' => 'bg-blue-100 text-blue-800',
      'archived' => 'bg-gray-100 text-gray-800'
    }
  end
end
