Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37917 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab3IHNbK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Sep 2013 09:31:10 -0400
Message-ID: <522C8A36.7010709@kernel.org>
Date: Sun, 08 Sep 2013 15:31:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <festevam@gmail.com>, jic23@cam.ac.uk,
	linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 2/2] iio: mxs-lradc: Add MODULE_ALIAS
References: <1378169292-29899-1-git-send-email-festevam@gmail.com> <1378169292-29899-2-git-send-email-festevam@gmail.com> <201309030259.50041.marex@denx.de>
In-Reply-To: <201309030259.50041.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/13 01:59, Marek Vasut wrote:
> Dear Fabio Estevam,
> 
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Add MODULE_ALIAS, so that auto module loading can work.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Acked-by: Marek Vasut <marex@denx.de>
Applied to the togreg branch of iio.git

Anyone fancy getting this driver into a clean form and proposing taking
it out of staging?

