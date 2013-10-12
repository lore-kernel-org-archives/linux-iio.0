Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46887 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396Ab3JLKkb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 06:40:31 -0400
Message-ID: <5259354D.8060806@kernel.org>
Date: Sat, 12 Oct 2013 12:41:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH v2 07/20] iio:apds9300: Use new event config interface
References: <1381155094-20166-1-git-send-email-lars@metafoo.de> <1381155094-20166-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-7-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/13 15:11, Lars-Peter Clausen wrote:
> Switch the apds9300 driver to the new IIO event config interface as the old one
> is going to be removed.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
