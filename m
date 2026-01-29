Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426434D385;
	Thu, 29 Jan 2026 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708028; cv=none; b=Bsa53CqtXJotibrXuuZrUDSuZ6LsMgroJUYDgBHHT3YnE6Cm6CN2fg1mw/XFFhfs6Me7+wbrLkx92AZPq7EJuShloFfniUvc0YdGbNWE63/YAgfVApz2OmnuUVXSkc+aLG0hTD1S4TsLMSTv+mjGR3B/uUoCopSKqWDy7tu3c/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708028; c=relaxed/simple;
	bh=Iz+3NGhX06Wa2TiCElqxja/M3e8BS4ZNFXfaat14t9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQNF34IcbczXRonPAhQ6G/pniwcOb52sAR5utTn1yZxAZlXVXNqCtxSwJcChrEmJZHqcf4m4DTuZY/admNwTdw2LgWpF4ACB2a3cdUYR9FEWM1ZcUo3Z5U7HN7unC46ZAe6BAYBAke2g8KeKCESG1JWqKBZ1qOQ1/CzTOTgP8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR3VVSbK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR3VVSbK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB2DC19425;
	Thu, 29 Jan 2026 17:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769708027;
	bh=Iz+3NGhX06Wa2TiCElqxja/M3e8BS4ZNFXfaat14t9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZR3VVSbKOEzNAsN9UEhed/S60d+y7WERiINMEChlMi/ZxfcHM9G5L740EUguRTGLX
	 jVVGU/FKa5L7FkrKeValjh3H+AR9QK/9tx1+zhmLY6++OAoGWHRdymQD3cbyAuibZM
	 1OiTD8apZhEPPiyu1Qe6C4P5ZwQ9L8p5syWCn3nayps+kY23PtY1f/PEbsq8KvRYgu
	 1f43+MqB/V/Z3pShBxRixFU1FaR0ymRVnHPrTkFyas8PvOARuSxYzohQG04tPLxa/Q
	 TsO4Gp/7ohOfQ8S5WngZfd2gGR8ie4iX/LVSVGVht9QhuuYOtTcuYvjFoAtXFdG3LG
	 99Dn5EJXD3Rug==
Date: Thu, 29 Jan 2026 17:33:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: me@brighamcampbell.com, skhan@linuxfoundation.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: iio: adxl345: Fix typos, units, and grammatical
 errors
Message-ID: <20260129173337.7fc2a4ad@jic23-huawei>
In-Reply-To: <20260127173543.72423-1-0rayn.dev@gmail.com>
References: <20260127173543.72423-1-0rayn.dev@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 12:34:51 -0500
Taha Ed-Dafili <0rayn.dev@gmail.com> wrote:

> Clean up the ADXL345 documentation to improve technical accuracy
> and readability:
> - Fix "latent" to "latency" in double tap descriptions.
> - Correct the threshold unit from "g/LSB" to "mg/LSB"
>   to match the datasheet.
> - Standardize "axis" to "axes" for plural references.
> - Change "generic purpose" to "general purpose".
> - Fix minor subject-verb agreement and punctuation errors.
> 
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
Hi Taha,

Thanks for looking at this.  Unfortunately you are the victim of making
people read it again and spot other issues :(

Not sure we can easily answer them but I have some concerns having
looked at this doc again. Seems at minimum the scaling presented by the driver
is wrong. Also the listing in this file for in_accel_scale_available is incorrect as well.

> ++---------------------------------------------+------------------------------------------------+
> +| Event handle                                | Description                                    |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_gesture_doubletap_en               | Enable double tap detection on all axes        |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_gesture_doubletap_reset_timeout    | Double tap window in [us]                      |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_gesture_doubletap_tap2_min_delay   | Double tap latency in [us]                     |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_gesture_singletap_timeout          | Single tap duration in [us]                    |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5 mg/LSB      |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_falling_period                 | Inactivity time in seconds                     |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5 mg/LSB      |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_adaptive_rising_en             | Enable AC coupled activity on X axis           |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds          |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5 mg/LSB |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5 mg/LSB   |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_rising_en                      | Enable activity detection on X axis            |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_rising_value                   | Activity threshold value in 62.5 mg/LSB        |

To be compliant with the ABI these should be in whatever is provided by in_accel_scale
which according to elsewhere in this doc is any of 0.478899 0.957798 1.915595 3.831190
which are in m/s^2 / LSB
None of those look like they are 62.5 mg

Given there is no other way of establishing scale, if the thresholds really don't change their
scaling with the sensor scale (which would be unusual) then we'd need to compensate the values
in these attributes so that they are still value * _scale ends up in m/s^2.

Those numbers for in_accel_scale are also wrong.  They should be as per the comment
in the driver
0.004789, 0.009578, 0.019156 and 0.038312

(so please fix that whilst you are here - probably in a separate patch as it's a fix
rather than tidying up.

As to what to do about the units.  Firstly, express them all in m/s^2 / LSB so we can more
easily spot the miss match.  Secondly looks like the driver needs a fix to have the right
scaling for these and that runs the risk of causing problems for anyone using it. 

We do have a fairly rarely used ABI option of adding ../events/in_accel_scale
(see Documentation/ABI/testing/sysfs-bus-iio) which allows us to indicate a different
scale factor from the main channel scaling.  That is probably the best approach here.
That would then reflect the scale in m/s^2 for each LSB which correpsonds to this 62.5 mg/LSB.


> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis          |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_x&y&z_mag_falling_en               | Enable inactivity detection on all axes        |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axes       |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_y_gesture_singletap_en             | Enable single tap detection on Y axis          |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_z_gesture_singletap_en             | Enable single tap detection on Z axis          |
> ++---------------------------------------------+------------------------------------------------+

