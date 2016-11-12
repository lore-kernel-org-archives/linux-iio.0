Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35455 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753115AbcKLPNJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 10:13:09 -0500
Subject: Re: [PATCH v2] iio: document bindings for mounting matrices
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1478616340-13670-1-git-send-email-linus.walleij@linaro.org>
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>, devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a6d866f2-ee20-282b-def0-f65de2177aee@kernel.org>
Date: Sat, 12 Nov 2016 15:13:06 +0000
MIME-Version: 1.0
In-Reply-To: <1478616340-13670-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/11/16 14:45, Linus Walleij wrote:
> The mounting matrix for sensors was introduced in
> commit dfc57732ad38 ("iio:core: mounting matrix support")
> 
> However the device tree bindings are very terse and since this is
> a widely applicable property, we need a proper binding for it
> that the other bindings can reference. This will also be useful
> for other operating systems and sensor engineering at large.
> 
> I think all 3D sensors should support it, the current situation
> is probably that the mounting information is confined in magic
> userspace components rather than using the mounting matrix, which
> is not good for portability and reuse.
Getting there and much easier to follow than previous version.

Kind of need to avoid glossing over the world magnetic field frame of
reference complexities though (that one is always a PITA to explain).

Jonathan
> 
> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Samu Onkalo <samu.onkalo@intel.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Repeat linear algebra and actually get the rotation matrix right.
> - Reference the Wikipedia article on the subject.
> - Fix up text.
> ---
>  .../devicetree/bindings/iio/mount-matrix.txt       | 108 +++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/mount-matrix.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/mount-matrix.txt b/Documentation/devicetree/bindings/iio/mount-matrix.txt
> new file mode 100644
> index 000000000000..a3714727f739
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/mount-matrix.txt
> @@ -0,0 +1,108 @@
> +Mounting matrix
> +
> +The mounting matrix is a device tree property used to orient any IIO device
> +that produce three-dimensional data in relation to the world where it is
"devices that produce" or "device that produces"
> +deployed.
> +
> +The purpose of the mounting matrix is to translate the sensor frame of
> +reference into the device frame of reference using a translation matrix as
> +defined in linear algebra.
> +
> +The typical usecase is that where a component has an internal representation
> +of the (x,y,z) triplets, such as different registers to read these coordinates,
> +and thus implying that the component should be mounted in a certain orientation
> +relative to some specific device frame of reference.
> +
> +For example a device with some kind of screen, where the user is supposed to
> +interact with the environment using an accelerometer, gyroscope or magnetometer
> +mounted on the same chassis as this screen, will likely take the screen as
> +reference to (x,y,z) orientation, with (x,y) corresponding to these axes on the
> +screen and (z) being depth, the axis perpendicular to the screen.
> +
> +For a screen you probably want (x) coordinates to go from negative on the left
> +to positive on the right and (z) depth to be negative under the screen and
> +positive in front of it, toward the face of the user.
> +
> +A sensor can be mounted in any angle along the axes relative to the frame of
> +reference. This means that the sensor may be flipped upside-down, left-right,
> +or tilted at any angle relative to the frame of reference.
> +
> +Another frame of reference is how the device with its sensor relates to the
> +external world, the environment where the device is deployed. Usually the data
> +from the sensor is used to figure out how the device is oriented with respect
> +to this world. When using the mounting matrix, the sensor and device orientation
> +becomes identical and we can focus on the data as it relates to the surrounding
> +world.
I'm not sure this last sentence is as clear as it might be... Perhaps

When the transformation represented by the mounting matrix has been applied to
sensor data, it may be treated as if it were in the device frame of reference
allowing us to focus on the data as it relates to the surrounding world.


> +
> +Device-to-world examples for some three-dimensional sensor types:
> +
> +- Accelerometers have their world frame of reference toward the center of
Stationary accelerometers (in earth frame)
> +  gravity, usually to the core of the planet. A reading of the (x,y,z) values
> +  from the sensor will give a projection of the gravity vector through the
> +  device relative to the center of the planet, i.e. relative to its surface at
> +  this point. Up and down in the world relative to the device frame of
> +  reference can thus be determined. and users would likely expect a value of
> +  9.81 m/s^2 upwards along the (z) axis, i.e. out of the screen when the device
> +  is held with its screen flat on the planets surface and 0 on the other axes,
> +  as the gravity vector is projected 1:1 onto the sensors (z)-axis.
> +
> +- Magnetometers (compasses) have their world frame of reference relative to the
> +  geomagnetic field. The system orientation vis-a-vis the world is defined with
> +  respect to the local earth geomagnetic reference frame where (y) is in the
> +  ground plane and positive towards magnetic North, (x) is in the ground plane,
> +  perpendicular to the North axis and positive towards the East and (z) is
> +  perpendicular to the ground plane and positive upwards.
Sadly it's not that simple for magnetometers due to the inclination angle...

Stand on the pole and the field points down making the concept of 'upwards'
interesing to define ;)

Some devices use an accelerometer to try and separate the two directions to
get what I think you are describing.

> +
> +- Gyroscopes detects the movement relative the device itself. The angular
> +  velocity is defined as orthogonal to the plane of rotation, so if you put the
> +  device on a flat surface and spin it around the z axis (such as rotating a
> +  device with a screen lying flat on a table), you should get a negative value
> +  along the (z) axis if rotated clockwise, and a positive value if rotated
> +  counter-clockwise according to the right-hand rule.
> +
> +So unless the sensor is ideally mounted, we need a means to indicate the
> +relative orientation of any given sensor of this type with respect to the
> +frame of reference.
> +
> +To achieve this, use the device tree property "mount-matrix" for the sensor.
> +This supplies a 3x3 rotation matrix in the strict linear algebraic sense,
> +to orient the senor axes relative to a desired point of reference. This means
> +the resulting values from the sensor, after scaling to proper units, should be
> +multiplied by this matrix to give the proper vectors values in three-dimensional
> +space, relative to the device or world point of reference.
> +
> +For more information, consult:
> +https://en.wikipedia.org/wiki/Rotation_matrix
> +
> +The mounting matrix has the layout:
> +
> + (x0, y0, z0)
> + (x1, y1, z1)
> + (x2, y2, z3)
> +
> +And it is represented as an array of strings containing the real values for
> +producing the transformation matrix. The real values use a decimal point and
> +a minus (-) to indicate a negative value.
> +
> +Examples:
> +
> +Identity matrix (nothing happens to the coordinates, which means the device was
> +mechanically mounted in an ideal way and we need no transformation):
> +
> +mount-matrix = "1", "0", "0",
> +               "0", "1", "0",
> +               "0", "0", "1";
> +
> +The sensor is mounted 30 degrees (Pi/6 radians) tilted along the X axis, so we
> +compensate by performing a -30 degrees rotation around the X axis:
> +
> +mount-matrix = "1", "0", "0",
> +               "0", "0.866", "0.5",
> +               "0", "-0.5", "0.866";
> +
> +The sensor is flipped 180 degrees (Pi radians) around the Z axis, i.e. mounted
> +upside-down:
> +
> +mount-matrix = "0.998", "0.054", "0",
> +               "-0.054", "0.998", "0",
> +               "0", "0", "1";
> 

