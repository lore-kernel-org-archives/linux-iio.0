Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60529 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbcGXTD1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 15:03:27 -0400
Subject: Re: [PATCH] iio: document bindings for mounting matrixes
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org>
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
	Sebastian Reichel <sre@kernel.org>,
	Samu Onkalo <samu.onkalo@intel.com>, devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <06168d06-b609-a0ec-945e-aa36a4dbe795@kernel.org>
Date: Sun, 24 Jul 2016 20:03:24 +0100
MIME-Version: 1.0
In-Reply-To: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/07/16 11:17, Linus Walleij wrote:
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
> 
> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Samu Onkalo <samu.onkalo@intel.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Please help out to get this right, I think this could be confusing
> to users unless documented properly. I think the doc has some rough
> edges since I'm not the smartest in physics nor english at all times.
Note that there is rather more substantial documentation in the
sysfs abi docs.

Documentation/ABI/testing/sysfs-bus-iio

That's not to say we shouldn't have better docs for the
binding, but rather that we should make sure they agree ;)

I'll try and take a look through this later in the week.

Jonathan
> ---
>  .../devicetree/bindings/iio/mount-matrix.txt       | 104 +++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/mount-matrix.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/mount-matrix.txt b/Documentation/devicetree/bindings/iio/mount-matrix.txt
> new file mode 100644
> index 000000000000..3e72c92c5689
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/mount-matrix.txt
> @@ -0,0 +1,104 @@
> +Mounting matrix
> +
> +The mounting matrix is a device tree property used to orient any IIO device
> +that produce three-dimensional data.
> +
> +The typical usecase is that where a component has an internal representation
> +of the (x,y,z) triplets, such as different registers to read these coordinates,
> +and thus implying that the component should be mounted in a certain orientation
> +relative to some specific point of reference.
> +
> +For example a device with some kind of screen, where the user is supposed to
> +interact with the environment using a accelerometer, gyroscope or magnetometer
> +mounted on the same chassis as this screen, will likely take the screen as
> +reference to (x,y,z) orientation, with (x,y) corresponding to these axes on the
> +screen and (z) being depth, the axis perpendicular to the screen.
> +
> +The axes may also be flipped: for a screen you probably want (x) coordinates to
> +go from negative on the left to positive on the right and (z) depth to be
> +negative under the screen and positive in front of it, toward the face of the
> +user.
> +
> +Apart from flipping, a sensor can of course also be mounted in any angle along
> +the axes relative to the point of reference. This means that the axes may be
> +not only flipped, but tilted.
> +
> +Examples for some three-dimensional sensor types:
> +
> +- Accelerometers have their frame of reference is toward the center of gravity,
> +  usually to the core of the planet, and users would likely expect a value of
> +  9.81N upwards along the (z) axis when the device is held with its screen
> +  perpendicular to the planets surface and 0 on the other axes. A reading of
> +  the (x,y,z) values will give the orientation of the device relative to the
> +  center of the planet, i.e. relative to its surface at this point. Up and down
> +  relative to the point of reference can thus be determined.
> +
> +- Magnetometers (compasses) have their frame of reference relative to the
> +  geomagnetic field. In a mounting matrix for a magnetometer sensor the main
> +  hardware orientation is defined with respect to the local earth geomagnetic
> +  reference frame where (y) is in the ground plane and positive towards
> +  magnetic North, (x) is in the ground plane, perpendicular to the North axis
> +  and positive towards the East and (z) is perpendicular to the ground plane
> +  and positive upwards.
> +
> +- Gyroscopes detects the movement relative the device itself, and has no other
> +  frame of reference than the mounting chassis itself. The angular momentum is
> +  defined as orthogonal to the plane of rotation, so if you put the device on a
> +  flat surface and spin it around the z axis (such as rotating a device lying
> +  flat on a table), you should get a negative value along the (z) axis if
> +  rotated clockwise, and a positive value if rotated counter-clockwise
> +  according to the right-hand rule.
> +
> +So unless the sensor is ideally mounted, we need a means to indicate the
> +relative orientation of any given sensor of this type.
> +
> +To achieve this, use the device tree property "mount-matrix" for the sensor.
> +This supplies a 3x3 transformation matrix in the strict linear algebraic sense,
> +to orient the senor axes relative to a desired point of reference. This means
> +the resulting values from the sensor, after scaling to proper units, should be
> +multiplied by this matrix to give the proper coordinates in three-dimensional
> +space, relative to some relevant point of reference.
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
> +Flipped X axis (negative values means positive):
> +
> +mount-matrix = "-1", "0", "0",
> +               "0", "1", "0",
> +               "0", "0", "1";
> +
> +X and Y flipped (X values are for Y and Y values are for X):
> +
> +mount-matrix = "0", "1", "0",
> +               "1", "0", "0",
> +               "0", "0", "1";
> +
> +Complex angular mounting with X and Z in a certain tilted orienation and
> +Y flipped:
> +
> +mount-matrix = "-0.984807753012208",  /* x0 */
> +               "0",                   /* y0 */
> +               "-0.173648177666930",  /* z0 */
> +               "0",                   /* x1 */
> +               "-1",                  /* y1 */
> +               "0",                   /* z1 */
> +               "-0.173648177666930",  /* x2 */
> +               "0",                   /* y2 */
> +               "0.984807753012208";   /* z2 */
> 

