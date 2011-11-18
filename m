Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:57554 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829Ab1KRNK1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Nov 2011 08:10:27 -0500
Date: 18 Nov 2011 13:10:24 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] staging:iio:dac: Add AD5380 driver
Message-ID: <Prayer.1.3.4.1111181310240.15942@hermes-2.csi.cam.ac.uk>
In-Reply-To: <1321613695-340-1-git-send-email-lars@metafoo.de>
References: <1321613695-340-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars,

My email client is eating all the line feeds, so this will have to be
out of line with the now unreadable code...

Having reorangised code, is the info_to_reg still worth having?

Otherwise, all looks good (and feel free to just delete the unused?
entry in that switch).

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>


