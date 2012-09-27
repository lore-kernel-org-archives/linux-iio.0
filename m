Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:35492 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754278Ab2I0SVE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Sep 2012 14:21:04 -0400
Message-ID: <506498F3.5050901@metafoo.de>
Date: Thu, 27 Sep 2012 20:20:35 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Senna Tschudin <peter.senna@gmail.com>
CC: Marek Vasut <marex@denx.de>, trivial@kernel.org, jic23@cam.ac.uk,
	gregkh@linuxfoundation.org, michael.hennerich@analog.com,
	w.sang@pengutronix.de, sfr@canb.auug.org.au, pmeerw@pmeerw.net,
	shubhrajyoti@ti.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/iio: Remove unnecessary semicolon
References: <1348748175-11803-1-git-send-email-peter.senna@gmail.com>	<1348752425-12818-1-git-send-email-peter.senna@gmail.com>	<201209271544.06716.marex@denx.de> <CA+MoWDokfgH45TzB+bBqVasd67isq5sStXyRrLh-863V_DjUaA@mail.gmail.com>
In-Reply-To: <CA+MoWDokfgH45TzB+bBqVasd67isq5sStXyRrLh-863V_DjUaA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/27/2012 04:40 PM, Peter Senna Tschudin wrote:
>>
>> The semantic patch is missing again ;-)
> 
> I know. The problem is that some people do not like to see semantic
> patches on the message, so I do not include it always... 

But this is really the most important part of the commit message for
auto-generated patches. How can I reproduce the changes made by the commit.
Just "Found by http://coccinelle.lip6.fr/" is kind of pointless in my opinion.

- Lars
