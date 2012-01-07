Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:34192 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab2AGKH0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jan 2012 05:07:26 -0500
Message-ID: <4F081977.2000807@cam.ac.uk>
Date: Sat, 07 Jan 2012 10:07:51 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	"arnd@arndb.de" <arnd@arndb.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: No pull request for IIO this merge window (out of staging)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


I thought I should write a quick email updating people on the current
situation.

Original plan was to send Linus a pull request for the basic core
support and 'pull' in-kernel interfaces.  When I backported the 'pull'
in-kernel interfaces to the staging tree (for speed they had been
developed against the simpler core support rather than the main version
of IIO in staging - seemed a good idea at the time), Greg KH took a look
and has raised some significant issues that we still need to address.
The sticky point is a disagreement about the best means of handling
mappings between channels on a child device and the IIO device.

Hence I have no intention of sending Linus a pull request for moving
any of IIO out of staging until these issues have been sorted out.

Saddly my time has now become rather more restricted so I am taking
longer to persue these issues.  Things aren't too bad as others have
stepped up to assist with the day to day burden of patch review and work
on the staging tree (thanks!).

Anyhow there have been lots of nice cleanups of the staging tree and
new work there, so it's not as though things aren't progressing. They
merely aren't going entirely according to plan!  Lots of good work
coming from Lars-Peter at ADI in particular. We also have our first SoC
adc driver from Maxime Ripard and some TI discrete device support from
Duss Pirmin.

Thanks

Jonathan

