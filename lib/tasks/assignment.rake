namespace :assignment do
  desc "Takes the latest assignment_version and create a new assignment_version with the same latest assignments. "
  task new_version: :environment do
    last_assignment = AssignmentVersion.last
    assignment_version = AssignmentVersion.create(description: "5 & 6 week version 9.12.16")
    #Week 1
    Assignment.create(assignment_version_id: assignment_version.id, week: 1, title: "exercise 0", question: "change me") #create exercise #0
    week_1_assignments = last_assignment.assignments.where(week:1).order(:id)
    create_exercises(week_1_assignments, assignment_version.id)
    #Week 2
    week_2_assignments = last_assignment.assignments.where(week:2).order(:id)
    create_exercises(week_2_assignments, assignment_version.id)
    Assignment.create(assignment_version_id: assignment_version.id, week: 2, title: "bonus 1", question: "change me"))
    Assignment.create(assignment_version_id: assignment_version.id, week: 2, title: "bonus 2", question: "change me"))
    Assignment.create(assignment_version_id: assignment_version.id, week: 2, title: "bonus 3", question: "change me"))
    #Week 3
    week_3_assignments = last_assignment.assignments.where(week:3).order(:id)
    create_exercises(week_3_assignments, assignment_version.id)
    Assignment.create(assignment_version_id: assignment_version.id, week: 3, title: "bonus 1", question: "change me"))
    Assignment.create(assignment_version_id: assignment_version.id, week: 3, title: "bonus 2", question: "change me"))
    Assignment.create(assignment_version_id: assignment_version.id, week: 3, title: "bonus 3", question: "change me"))
  end

  def create_exercises(assignments, id)
    assignments.each do |assignment|
      new_assignment = assignment.dup
      new_assignment.assignment_version_id = id
      new_assignment.save
    end
  end

end
