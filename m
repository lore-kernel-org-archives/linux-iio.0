Date: 07 Mar 2010 12:39:26 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [RFC] IIO event naming.
Message-ID: <Prayer.1.3.2.1003071239260.10684@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Dear All,

Whilst converting the current mainline IIO accelerometer drivers over to
the new api proposed (latest version http://lkml.org/lkml/2010/2/5/205 )
it has become apparent that the suggested naming choices for accelerometer
threshold events (will also be relevant to other senor types) are unclear.

We proposed control interfaces named as:
  /sys/.../device[n]:event[m]/accel_x0_thresh[_high|_low]

Firstly with hindsight the high / low designation isn't clear. Does it 
refer to the direction of the threshold? (value falling or rising) or
to the actual value lying on either side of the origin?  (what I actually
meant)  Secondly how do we indicate a threshold based on magnitude rather
than absolute value? 

What I have come up with is:

accel_x0_mag[_pos|_neg|_either][_rising|_falling|_crossing]

By defining the threshold in terms of a magnitude in conjunction with
terms specifying which magnitude it refers to, is the only simply way
I can think of covering all the cases.

[_pos|_neg|_either] refers to the two directions of acceleration where
_either covers the general magnitude case.

[_rising|_falling|_crossing] refers to whether our threshold is on the
acceleration magnitude in the specified direction triggering an interrupt
if it is rising, falling or either of the above.

What do people think about this naming convention?  Are there any similar
situations elsewhere in the kernel from which we can learn?

Obviously all of the above will apply to the different event types, it is
merely easier in someways to grasp the issue when dealing with something
as concrete as acceleration.

Thanks,

Jonathan

p.s. Sorry I haven't cc'd those who have previously expressed interest in
these areas.  I don't have access to my address book from this machine.
