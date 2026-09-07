Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB52F6596;
	Mon,  7 Sep 2026 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746089; cv=none; b=aLHIszP6fd77ak5TWoB1AyUegYdOqzC8jPV3/Sqe6JyZGcbCirvBZnf5LvcZdQqnloAgjFs09wZxAOzkgjTiDp0eIkFhZDKdCG7YyJAk2OihDZmr4JajxQoS4kFcPuIn4OBenNSqnawhYZXIxOmLEHKikI6FYvuFR3syMoJ/FG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746089; c=relaxed/simple;
	bh=1AI0dKaOI65yf1+rfxltbIkAsJQpiGcpaW89EreOMv8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Em+LgFleIPlVfIxmNxzInC1fDURdAnJc6PrdMPEkLIynzsjCMNUrYJolhCpnX4roV6X0tE2a+EaluiltOr/unVzzLIqX9euE2fmGIhlWVjMO6lJ8q2Yz7xa1Gb4LHt1Rzg5DdF9vVFPsJWOozutwW0tZrgd49JRSaWSkUEYDGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP1joD+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP1joD+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AE71F00A3A;
	Mon,  7 Sep 2026 01:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746087;
	bh=ZjZk/T3T7cS/RqaqOE2LmS2HRZNX8JaAOt02nJKe9fY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=XP1joD+RS+zy7Fu5hg4dLHHIdWVnrT5cDS8RQF5bCs90R+Nxvcp6WaC6LwFvtmOff
	 awT+voaG3+DRI5h+q+dp9ZrsFdNCcyfONtO+21ylfvx2xrfUltZN6XsgzHKqlXYrtv
	 ZHaWBzHZ6Qb55C1qVYIxFzftpe5tzp1hQQZ3LpfcTTDDZ7eVx9dDyiQwO6FGRUuqLI
	 pRdRFSyGwWX83/agztY/sVRaOw2E+chj99pzAoWutdXlb0InDwH8lYtQwicvSt/xp2
	 YhhAzwhhtQfDU4it8hLUJTBfUEucCyWotuiTB/TT0l6RhXc8s0kp+LvsPGwoKU2t4d
	 RWGM+WV40NlbQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/8] Add support for InvenSense ICM-42370-P
 accelerometer
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kanak Shilledar <kanak.shilledar@axis.com>, 
 Henrik Grimler <henrik.grimler@axis.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <ape0FNy38B_0RyN4@ashevche-desk.local>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
 <ape0FNy38B_0RyN4@ashevche-desk.local>
Date: Mon, 07 Sep 2026 02:54:30 +0100
Message-Id: <178874607008.3402141.6398096154260490037.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=1AI0dKaOI65yf1+rfxltbIkAsJQpiGcpaW89EreOMv8=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnhlXbWdO3wFFdP61a3Kghm3ky8LhZNJNHyg3p
 NiBm/iYCJiJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCap4ZVxEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiCPiEAC1ICpewwSaASUm++fBaH+3IIuP5VsVXjtG/430MEtGVa+
 AhuoNxgLr3oUdd4C4V/GBcPEcSU33TAX+pq41kOXCtfydr+cW8uTfChe2gTwbwQ1gcLie2NJYNX
 X2IemjNBPMctGUzTCbjA7+d7PJytfMi4ZgE7dFZp+uyQInxO3fDOS+e5E6uD/XW09wUY5V/yKKY
 6S9c7UzmE+Mx3Rx9v2RRmwNvOq20Cw/eduOeWW+gKIDqnt79d1NVk5cmWADsitsZ2pc3sdo+BOk
 yi8b/NG4tAbUawqQ33WwLwq4PyndxFwds7zmDSRoZXibsKJ08+tr9JS+DYPSVArVdQA7anZMQ/Z
 y/JZtGVHgGieXteeZwtAP+mVp69NlF/rwypmVLQb5ce9EKo3XtcTCqXosfWWATBCGYMZqWUo1vG
 7XXIR1rtMhGSLJckwo/8ZdbVjDv5nq5iZRQN/HO1C5x2/bWt5nZgigqaY+ukJVr4ma042mxdnYR
 YguYZH1Of+KA72cozmyfTFnI5jeTiAXDcQ9jCV8+4z3Mt85lBLaXkefTtzo/a5WALO7VazH3U20
 q7xhBPSWihS77V4ks0ngDbfWmeteBAz1KNFpK6YJFkGHCDqnWYIDw3w6do65ueYMINboGS5iJrY
 u30ShpUy2RwpU94XcQq+Bi1KuKF/0GxlkWZwO9g==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

On 2026-09-02 08:30:07+03:00, Andy Shevchenko wrote:
> On Tue, Sep 01, 2026 at 04:35:53PM +0200, Kanak Shilledar wrote:
> 
> > InvenSense ICM42370P is a high performance MEMS MotionTracking 3-axis
> > accelerometer. It supports I2C, I3C and SPI protocols. It has a 2.25kB
> > FIFO and two programmable interrupts with support for ultra-low-power
> > wake-on-motion support. It has a built-in temperature sensor. This
> > patch series adds basic support for the sensor with functionality of
> > performing raw reads and writes via the I2C interface.
> > 
> > This device contains 4 register banks for configuring the device called
> > MREG0, MREG1, MREG2 and MREG3. Unlike other devices from the same
> > vendor, this contains a very different way of accessing the register
> > banks apart from the default user bank 0 (MREG0). The register bank access
> > procedure is mentioned in the datasheet Section 13. This is very
> > similar to the existing InvenSense, ICM-42607-P driver. Thus, it
> > improves the existing driver support and adds the ICM-42370-P device to
> > it.
> > 
> > While adding the support for new device, I tried to perform some fixes
> > to the existing driver which were pointed out in the v2 of this patch
> > series.
> > 
> > The buffer support will be added in another patch series.
> > 
> > Note: The datasheet for InvenSense, ICM-42607-P could not be found on the 
> > official https://www.invensense.tdk.com/en-us website. Thus, I am 
> > using the datasheet available at https://www.lcsc.com.
> > 
> > Question to the reviewers:
> > * There is no entry for drivers/iio/imu/inv_icm42607 in the MAINTAINERS
> >   file, should a new MAINTAINERS entry be created for the inv_icm42607
> >   driver with the original author as the maintainer? Currently
> >   `get_maintainers.pl` is able to add the original author to the
> >   recipients list, but `b4 prep --auto-to-cc` is not able to add.
> 
> Only if you have (or will have for sure) the confirmation from them.
> Otherwise it's you most likely...

Chris only just got this one merged so let us wait to here from him.
> 
> > * As per the comments in v2 from @Jonathan regarding splitting the
> >   driver into multiple files, should we still have the driver as
> >   multiple files or should it be merged into a single file?
> 
> It depends on the factors like busses to support.
It is fine to have it split given it's an existing driver and supports
more complex hardware.

Jonathan



