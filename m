Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35376 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbcINJGF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Sep 2016 05:06:05 -0400
Received: by mail-pf0-f194.google.com with SMTP id z84so491524pfi.2
        for <linux-iio@vger.kernel.org>; Wed, 14 Sep 2016 02:06:05 -0700 (PDT)
Message-ID: <1473843953.23872.3.camel@researchut.com>
Subject: Re: possible odd acceleration scaling
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Date: Wed, 14 Sep 2016 14:35:53 +0530
In-Reply-To: <1473793566.6874.10.camel@linux.intel.com>
References: <1473787814.8047.8.camel@researchut.com>
         <a9078c9f-0d07-35bc-e449-2cfeee7b7987@kernel.org>
         <d275ff67-4335-a6f4-b60b-c4227a59b34c@kernel.org>
         <1473793566.6874.10.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Srinivas,

On Tue, 2016-09-13 at 12:06 -0700, Srinivas Pandruvada wrote:
> Again somehow we think that X is at byte index 8, Y at byte index 4,
> and Z at byte index 8. Looks like it got reversed.
> It should be 0, 4 and 8 respectively.
> 
> Can you try reverting this commit in iio-sensor-proxy? If it is then
> this is some indexing issue we still need to address:
> 
> "buffer-utils: Fix orientation axis switch using 4.8 kernel"

Not much changed even after reverting that commit.


With iio-sensor-proxy, 1.2, I get:

rrs@learner:/var/tmp/Debian-Build/Result$ monitor-sensor 
    Waiting for iio-sensor-proxy to appear
+++ iio-sensor-proxy appeared
=== Has accelerometer (orientation: right-up)
=== Has ambient light sensor (value: 0.000000, unit: lux)
    Accelerometer orientation changed: left-up
    Accelerometer orientation changed: right-up
    Accelerometer orientation changed: left-up
    Accelerometer orientation changed: right-up
- --- iio-sensor-proxy vanished, waiting for it to appear


Notice that there is no 'normal' orientation mode reported.

Now reverting back to 1.1 of iio-sensor-proxy, I get:

+++ iio-sensor-proxy appeared
=== Has accelerometer (orientation: undefined)
=== Has ambient light sensor (value: 0.000000, unit: lux)
+++ Accelerometer appeared
    Accelerometer orientation changed: undefined
+++ Light sensor appeared
    Light changed: 0.000000 (lux)
    Accelerometer orientation changed: right-up
    Accelerometer orientation changed: normal
    Accelerometer orientation changed: right-up


This is on Linux 4.8-rc6.

- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX2RLxAAoJEKY6WKPy4XVpC5QP/iovkuF7jLdJVMqheL4TRxGz
N+q7Q/DqV/bHg6qb0S5rsetSeL/aT31zeWUc0eX3ftjGjIoT/0G4HE1jOsfrYLot
q8q3ZGpY4HvGAkijqB7aS8M9tAnVrwpQdEVKx3SIFj5rbWvMEzXZOr6n50Nu7GZy
O7ZYH2zfNOMAJMZzLZtBcI9bX9HtLbHptVVWE7oDxNFFYniLiRxw2nOBTQ0zfYo6
DeU7iIQIu4tyRe2x/EbFxXQIm21PfkMkVI4Hhb3utCOO9Z33e4HnVfllGm4Jke0J
YoCk7h4uGhY6WvmzNRKxN3dxZ33M4YVZUbrKEz5ccqBOtwn8DcR+4W71hq72Bpqy
PDYwUR1WxIIhKI8tg9KPUs6lHOg/KV//c2xKz6yWNLS68S+tUUp9c/EAgLoJ4kPO
Oxym0D+QhA5i4H4VTKjXtqNLE5MDSy+eVTHZCqnWeZT/++D6eLWDrRDYMvKQLFiv
nlwW0eL2b8mu+gDrPZE1xsC2awxrg+faY2xtxIevKCYE2U8fp3/FH2hLlET4I+6O
ITieTrGD2jdkjOj8XWywBT0ZsH8+1DJC6fkqvbVmv2KA21NOnFiCK4mhEW625d3S
rbKDMYzFYBSMEVNVXTVRjEwfOvI2oGaPsJVVvXKh4IQoKdN5DS2ssVxvmf4af54F
DIhMxIWhwl1rQho3FB9g
=yCj8
-----END PGP SIGNATURE-----

