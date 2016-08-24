Return-Path: <gregor.boirie@parrot.com>
Message-ID: <57BD9EB6.1090504@parrot.com>
Date: Wed, 24 Aug 2016 15:18:46 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, Samu Onkalo <samu.onkalo@intel.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] iio: document bindings for mounting matrixes
References: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org> <CACRpkdY0gCLKD3rmiYuFgWSYOe6dtUaBeRi1ns-UFF=AspntFg@mail.gmail.com> <c8e83cf2-f9dc-0bc9-fcde-326b05ee290b@kernel.org>
In-Reply-To: <c8e83cf2-f9dc-0bc9-fcde-326b05ee290b@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Linus, Jonathan,

my little bit there... at last. comments in line.


On 08/21/2016 05:56 PM, Jonathan Cameron wrote:
> On 24/07/16 11:17, Linus Walleij wrote:
>> The mounting matrix for sensors was introduced in
>> commit dfc57732ad38 ("iio:core: mounting matrix support")
>>
>> However the device tree bindings are very terse and since this is
>> a widely applicable property, we need a proper binding for it
>> that the other bindings can reference. This will also be useful
>> for other operating systems and sensor engineering at large.
>>
>> I think all 3D sensors should support it, the current situation
>> is probably that the mounting information is confined in magic
>> userspace components rather than using the mounting matrix, which
>> is not good for portability and reuse.
>>
>> Cc: Gregor Boirie <gregor.boirie@parrot.com>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Cc: Samu Onkalo <samu.onkalo@intel.com>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Hi Linus,
>
> Sorry I took so long to get to this...
> (out of curiosity are you running a fifo queue of patches? Every time
> I review and merge one, another one turns up in my inbox :)
>> ---
>> Please help out to get this right, I think this could be confusing
>> to users unless documented properly. I think the doc has some rough
>> edges since I'm not the smartest in physics nor english at all times.
>> ---
> I think we have quite a bit of confusion of measurement frames here.
> (it always confused me when I was doing day to day work with these - now
> I'm decidedly rusty!)
>>   .../devicetree/bindings/iio/mount-matrix.txt       | 104 +++++++++++++++++++++
>>   1 file changed, 104 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/mount-matrix.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/mount-matrix.txt b/Documentation/devicetree/bindings/iio/mount-matrix.txt
>> new file mode 100644
>> index 000000000000..3e72c92c5689
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/mount-matrix.txt
>> @@ -0,0 +1,104 @@
>> +Mounting matrix
>> +
>> +The mounting matrix is a device tree property used to orient any IIO device
>> +that produce three-dimensional data.
>> +
>> +The typical usecase is that where a component has an internal representation
>> +of the (x,y,z) triplets, such as different registers to read these coordinates,
>> +and thus implying that the component should be mounted in a certain orientation
>> +relative to some specific point of reference.
> point of reference -> device frame of reference.
+1.
Makes me think we should probably use the same terminology in DT 
bindings and
IIO ABI docs.
What Jonathan calls "device frame of reference" was named as "main hardware
reference frame" in IIO docs. For fixed wings UAVs the most common term 
would
be "body frame".
I think we should pick one and stick with it.

Moreover as, told below, we have to make a clear distinction between 
"world",
"device/main hardware" and "sensor" reference frames.
>> +
>> +For example a device with some kind of screen, where the user is supposed to
>> +interact with the environment using a accelerometer, gyroscope or magnetometer
>> +mounted on the same chassis as this screen, will likely take the screen as
>> +reference to (x,y,z) orientation, with (x,y) corresponding to these axes on the
>> +screen and (z) being depth, the axis perpendicular to the screen.
> Good description.
>> +
>> +The axes may also be flipped: for a screen you probably want (x) coordinates to
>> +go from negative on the left to positive on the right and (z) depth to be
>> +negative under the screen and positive in front of it, toward the face of the
>> +user.
> I'm not sure we don't want to define that it can't be flipped and enforce the
> correct coordinate system on the underlying drivers (fingers crossed they are
> currently all left or all right handed? - oops should have been keeping an eye on
> this).
As to coordinate system definition, multiple conventions seem to exist 
across
industries. For UAV, we use the one described here:
https://en.wikipedia.org/wiki/Flight_dynamics_(fixed-wing_aircraft)

So I feel like we should keep away from any temptation to define the 
coordinates
system too strictly.
I also think of systems composed of multiple hardware parts with sensors
scattered all over them. What would be the right "device/main hardware" 
reference
frame definition in these cases ?
As this is product specific, I feel like "device/main hardware" 
reference frame
definition should be left to the "board/main hardware/device..." 
implementor's
choice.
>> +
>> +Apart from flipping, a sensor can of course also be mounted in any angle along
>> +the axes relative to the point of reference. This means that the axes may be
>> +not only flipped, but tilted.
> Just define it as a frame of reference, rather than a point and axis.  Frame hides
> all evils ;)
+1
> For now we are being a bit simplistic as for accelerometers at least, it can be
> of interest to know the translation as well as the rotation.  You can use a couple
> of them to do fairly precise rotation estimate if they are located in different
> places on a device.
>
>> +
>> +Examples for some three-dimensional sensor types:
>> +
>> +- Accelerometers have their frame of reference
> Not quite right.  Their frame of reference is in the frame of the device - it has
> nothing to do with the world frame which you are describing here (except when
> the device is deliberate oriented to match.
>
> So we have 3 frames - that of the sensor, that of the device and that of the world.
>
> Sensor --<mounting matrix transform>--> Device frame --<Device to world transform> -->
> world frame.
> For the static no motion cases - when moving the acceleration needs to take into account
> what the motion is etc (magnetometer doesn't).
+1

[snip....]

Except for the above mentioned points, I'm happy with the rest of the
description.

best regards,
Grég.

> All the below kind of merge the mounting matrix transform with the device to world
> transform and leave me at least somewhat confused :)
>
>   is toward the center of gravity,
>> +  usually to the core of the planet, and users would likely expect a value of
>> +  9.81N upwards along the (z) axis when the device is held with its screen
>> +  perpendicular to the planets surface and 0 on the other axes.
> I'd have thought screen parallel  - i.e. z is out of the screen?
> Might be the same thing I suppose, but I'd define it simply as into the screen
> then y towards top of screen and x from left to right of the screen.
>   A reading of
>> +  the (x,y,z) values will give the orientation of the device relative to the
>> +  center of the planet, i.e. relative to its surface at this point. Up and down
>> +  relative to the point of reference can thus be determined.
> Will give a project of the gravity vector onto the axis of the sensor. There
> is I think a world to local frame transform missing here...
>
>> +
>> +- Magnetometers (compasses) have their frame of reference relative to the
>> +  geomagnetic field. In a mounting matrix for a magnetometer sensor the main
>> +  hardware orientation is defined with respect to the local earth geomagnetic
>> +  reference frame where (y) is in the ground plane and positive towards
>> +  magnetic North, (x) is in the ground plane, perpendicular to the North axis
>> +  and positive towards the East and (z) is perpendicular to the ground plane
>> +  and positive upwards.
> Same issue, world to frame transform is not included...
>> +
>> +- Gyroscopes detects the movement relative the device itself, and has no other
>> +  frame of reference than the mounting chassis itself.
> This is true for all of them as far as we are concerned here...
>> The angular momentum is
> Hang on, where did momentum come into it from?  Mems gyros are detecting rate
> of change of rotation about an axis (lets ignore the significant cross talk and
> effects of linear acceleration and pretend it's all easy here ;)
>
> Rest of this description is fine.
>> +  defined as orthogonal to the plane of rotation, so if you put the device on a
>> +  flat surface and spin it around the z axis (such as rotating a device lying
>> +  flat on a table), you should get a negative value along the (z) axis if
>> +  rotated clockwise, and a positive value if rotated counter-clockwise
>> +  according to the right-hand rule.
>> +
>> +So unless the sensor is ideally mounted, we need a means to indicate the
>> +relative orientation of any given sensor of this type.
>> +
>> +To achieve this, use the device tree property "mount-matrix" for the sensor.
>> +This supplies a 3x3 transformation matrix in the strict linear algebraic sense,
>> +to orient the senor axes relative to a desired point of reference. This means
>> +the resulting values from the sensor, after scaling to proper units, should be
>> +multiplied by this matrix to give the proper coordinates in three-dimensional
> vector values as opposed to coordinates...
>> +space, relative to some relevant point of reference.
> Within the frame of the device.
>> +
>> +The mounting matrix has the layout:
>> +
>> + (x0, y0, z0)
>> + (x1, y1, z1)
>> + (x2, y2, z3)
>> +
>> +And it is represented as an array of strings containing the real values for
>> +producing the transformation matrix. The real values use a decimal point and
>> +a minus (-) to indicate a negative value.
>> +
>> +Examples:
>> +
>> +Identity matrix (nothing happens to the coordinates, which means the device was
>> +mechanically mounted in an ideal way and we need no transformation):
>> +
>> +mount-matrix = "1", "0", "0",
>> +               "0", "1", "0",
>> +               "0", "0", "1";
>> +
>> +Flipped X axis (negative values means positive):
>> +
>> +mount-matrix = "-1", "0", "0",
>> +               "0", "1", "0",
>> +               "0", "0", "1";
> Hmm. This is an odd one as it basically means the device had a right hand
> coordinate system in the first place... If that happens I think we should
> by default report the negative of the scale for that axis.
>
> We've never strictly defined a coordinate system but I think left handed
> is a good start!
>> +
>> +X and Y flipped (X values are for Y and Y values are for X):
>> +
>> +mount-matrix = "0", "1", "0",
>> +               "1", "0", "0",
>> +               "0", "0", "1";
> Same with this one, we are flipping coordinate systems.  I'd expect only
> rotation matrices to be valid mount matrices.
>> +
>> +Complex angular mounting with X and Z in a certain tilted orienation and
> orientation
>> +Y flipped:
>> +
>> +mount-matrix = "-0.984807753012208",  /* x0 */
>> +               "0",                   /* y0 */
>> +               "-0.173648177666930",  /* z0 */
>> +               "0",                   /* x1 */
>> +               "-1",                  /* y1 */
>> +               "0",                   /* z1 */
>> +               "-0.173648177666930",  /* x2 */
>> +               "0",                   /* y2 */
>> +               "0.984807753012208";   /* z2 */
>>
> Anyhow, now my head hurts.
>
> Jonathan
