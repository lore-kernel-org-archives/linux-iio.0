Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46408 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692Ab3H2Trp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2013 15:47:45 -0400
Message-ID: <521FB371.1030005@kernel.org>
Date: Thu, 29 Aug 2013 21:47:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Josh Wu <josh.wu@atmel.com>, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: at91: introduce the multiple compatible string
 for different IPs.
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com> <1377602932-1899-3-git-send-email-josh.wu@atmel.com> <20130828080200.GM2695@lukather>
In-Reply-To: <20130828080200.GM2695@lukather>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/28/13 09:02, Maxime Ripard wrote:
> Hi Josh,
> 
> On Tue, Aug 27, 2013 at 07:28:48PM +0800, Josh Wu wrote:
>> As use the multiple compatible string, we can remove hardware register in dt.
>> 
>> CC: devicetree@vger.kernel.org Signed-off-by: Josh Wu <josh.wu@atmel.com>
> 
> It's ok for me. You can add my Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
I've assumed for such and obviously good change that none of the devicetree
maintainers need to give an ack and applied this to the togreg branch of iio.git

Thanks,

Jonathan
> 
> Thanks! Maxime
> 
