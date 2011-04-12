Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:26958 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab1DLLIZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2011 07:08:25 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>,
	"broonie@opensource.wolfsonmicro.com"
	<broonie@opensource.wolfsonmicro.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Tue, 12 Apr 2011 12:08:22 +0100
Subject: voltage and current regulator framework: specifying negative
 voltages
Message-ID: <544AC56F16B56944AEC3BD4E3D59177137546EF3FC@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Mark and Liam,

I wonder why the voltage and current regulator framework doesn't support negative voltages.
We like to use the framework to specify bipolar reference voltages used with converters.
However in various places negative voltages are treated as error codes, thus causing the regulator to exit on probe.

As a workaround someone could say we specify positive and negative supply by label with absolute values and add the negative sign in the consumer driver.
However that doesn't work well, since the bipolar 'negative' supply may also occasionally be positive.

Thoughts?

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif

