Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36635 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbcESVNP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 May 2016 17:13:15 -0400
In-Reply-To: <CADRpq-CwYpwvwST3+ZHyyn6pquxndC5GJWDKZK7zR8cff_Ky-Q@mail.gmail.com>
References: <CADRpq-CwYpwvwST3+ZHyyn6pquxndC5GJWDKZK7zR8cff_Ky-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Drivers for Bitland Dual Accelerometer
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 19 May 2016 22:12:36 +0100
To: Lasse Schuirmann <lasse.schuirmann@gmail.com>,
	linux-iio@vger.kernel.org
Message-ID: <3E7E6B30-8926-4C0F-ADA6-2750C2A748B5@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 19 May 2016 19:14:52 BST, Lasse Schuirmann <lasse.schuirmann@gmail.com> wrote:
>Hi,
>
>I'm trying to use Linux on a Lenovo Yoga 300 and can't get the
>accelerometer running. It was suggested at
>https://github.com/hadess/iio-sensor-proxy/issues/83#issuecomment-220399560
>that I contact this mailing list as no driver seems to exist yet.
>
>The device in question is an accelerometer from "Bitland Corporation"
>with the APCI ID "DUAL250E".
>
>Windows drivers seem to be available at
>http://driverlibs.com/download/Dual-Accelerometer.
>
>I wonder if somebody possibly has the same problem and/or would be
>interested in helping getting this to work.
>
>Sincerely,
>
>Lasse Schuirmann

Hmm long shot but any idea if it could be a rebadged bma250e which is a Bosch
 sensortech part? Not sure what the dual bit would be about though.

Digging in those windows drivers may give us more info.  They are on lenovos
 website as well.

On phone right now but will have a look tomorrow.

Jonathan
>
>lasse@schuirmann.net
>http://coala-analyzer.org/ - http://viperdev.io/ - http://gitmate.com/
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
