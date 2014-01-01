Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45549 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbaAAMGD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jan 2014 07:06:03 -0500
Message-ID: <52C404A2.9030106@kernel.org>
Date: Wed, 01 Jan 2014 12:05:54 +0000
From: Jonathan <jic23@kernel.org>
MIME-Version: 1.0
To: Kevin Tsai <ktsai@capellamicro.com>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Rob Landley <rob@landley.net>,
	Grant Likely <grant.likely@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Teddy Reed <teddy@prosauce.org>,
	Kent Yoder <key@linux.vnet.ibm.com>,
	Arnaud Ebalard <arno@natisbad.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
	Jacek Anaszewski <j.anaszewski@samsung.com>
CC: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH V4 1/1] iio: add Capella CM32181 ambient light sensor
 driver.
References: <1387850035-4030-1-git-send-email-ktsai@capellamicro.com>
In-Reply-To: <1387850035-4030-1-git-send-email-ktsai@capellamicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 24/12/13 01:53, Kevin Tsai wrote:
> Add Capella Microsystem CM32181 Ambient Light Sensor IIO driver.
> This driver will convert raw data to lux value under open-air
> condition. Change the calibscale based on the cover material.
>
> Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
> ---
Hi Kevin,

It is good practice to list here (nothing from here goes in final commit
message) any changes since the previous version.  This just makes it clear
whether you have responded to all review comments, particularly when there
are multiple people reviewing the patch.


Other than that, I'm happy with this and have applied it to the togreg 
branch of iio.git - initially pushed out as testing for build tests.

Note I made one tiny white space change (dropped a blank line where 
there were two...

