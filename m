Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-221.synserver.de ([212.40.185.221]:1088 "EHLO
	smtp-out-221.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab3GPLQD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 07:16:03 -0400
Message-ID: <51E52B9B.5030407@metafoo.de>
Date: Tue, 16 Jul 2013 13:16:43 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Josh Wu <josh.wu@atmel.com>, jic23@cam.ac.uk,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	plagnioj@jcrosoft.com, nicolas.ferre@atmel.com
Subject: Re: [PATCH 4/5] iio: at91: add an optional dt property for for adc
 clock hz.
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com> <1373789069-11604-5-git-send-email-josh.wu@atmel.com> <20130715130610.GD2962@lukather> <51E4FC70.3050207@atmel.com> <20130716103014.GB3125@lukather>
In-Reply-To: <20130716103014.GB3125@lukather>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/16/2013 12:30 PM, Maxime Ripard wrote:
[...]
>> After a further thinking of this, maybe remove the adc_op_clk is
>> better since it is a fake clock, and only used to specify the clock
>> rate.
>> To specify the clock rate use a dt property or platform data
>> parameter is better.
> 
> No, to specify *any* clock, the common clock framework is the better
> solution.

Yep, this patch is not the right approach. It's trying to work around the
limitations of the platforms clock API implementation. Please fix the at91
clock implementation instead (e.g. by switching to the common clock framework).

- Lars

