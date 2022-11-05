#############
Heading 1
#############

*************
Heading 2
*************

===========
Heading 3
===========

Heading 4
************

Heading 5
===========

Heading 6
~~~~~~~~~~~

Text

Numbered
~~~~~~~~~~~

#. Select **Advanced Settings**.
#. Find the **Course Advertised Start Date** policy key.
#. Enter the value you want to display.

Bulleted
~~~~~~~~~~~

* Who is teaching the course?
* What university or college is the course affiliated with?
* What topics and concepts are covered in your course?
* Why should a learner enroll in your course?

Mixed
~~~~~~~~~~~

#. Review your entry to verify that the key is accurate and that it is
   surrounded by quotation marks. If there is a list of keys, they must be
   comma separated.

   * In this example, the key for the Annotation Problem tool is the only
     value in the list.

   * In this example, the key for the Annotation Problem tool is added at
     the beginning of a list of other keys.

#. Select **Save Changes**.

* Review your entry to verify that the key is accurate and that it is
  surrounded by quotation marks. If there is a list of keys, they must be comma
  separated.

  #. In this example, the key for the Annotation Problem tool is the only
     value in the list.

  #. In this example, the key for the Annotation Problem tool is added at the
     beginning of a list of other keys.

* Select **Save Changes**.

Multilevel
~~~~~~~~~~~

#. Review your entry to verify that the key is accurate and that it is
   surrounded by quotation marks. If there is a list of keys, they must be
   comma separated.

   #. In this example, the key for the Annotation Problem tool is the only
      value in the list.

   #. In this example, the key for the Annotation Problem tool is added at
      the beginning of a list of other keys.

#. Select **Save Changes**.

Note
~~~~~~~~~~~

.. note::
   This is note text. If note text runs over a line, make sure the lines wrap
   and are indented to the same level as the note tag. If formatting is
   incorrect, part of the note might not render in the HTML output.

   Notes can have more than one paragraph. Successive paragraphs must indent
   to the same level as the rest of the note.

Warning
~~~~~~~~~~~

.. warning::
   Warnings are formatted in the same way as notes. In the same way, lines
   must be broken and indented under the warning tag.

list-table
~~~~~~~~~~~

.. list-table::
   :widths: 15 15 60
   :header-rows: 1

   * - Field
     - Type
     - Details
   * - ``correct_map``
     - dict
     - For each problem ID value listed by ``answers``, provides:

       * ``correctness``: string; 'correct', 'incorrect'
       * ``hint``: string; Gives optional hint. Nulls allowed.
       * ``hintmode``: string; None, 'on_request', 'always'. Nulls allowed.
       * ``msg``: string; Gives extra message response.
       * ``npoints``: integer; Points awarded for this ``answer_id``. Nulls allowed.
       * ``queuestate``: dict; None when not queued, else ``{key:'', time:''}``
         where ``key`` is a secret string dump of a DateTime object in the form
         '%Y%m%d%H%M%S'. Nulls allowed.

   * - ``grade``
     - integer
     - Current grade value.
   * - ``max_grade``
     - integer
     - Maximum possible grade value.
