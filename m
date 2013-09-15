Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52820 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756844Ab3IOPU7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 11:20:59 -0400
Message-ID: <5235DE78.9040806@kernel.org>
Date: Sun, 15 Sep 2013 17:21:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org, kyungmin.park@samsung.com,
	s.nawrocki@samsung.com
Subject: Re: [PATCH v9] iio: gp2ap020a00f: Add a driver for the device
References: <1378740209-2249-1-git-send-email-j.anaszewski@samsung.com>
In-Reply-To: <1378740209-2249-1-git-send-email-j.anaszewski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 09/09/13 16:23, Jacek Anaszewski wrote:
> Add a new driver for the ambient light/proximity sensor
> device. The driver exposes three channels: light_clear
> light_ir and proximity. It also supports triggered buffer,
> high and low ambient light threshold event and proximity
> detection events.
>
> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Very nice driver for a beast of a device.  Far as I can see you've
managed to handle all the weird corners due to the limited
interrupt generator and auto switching the gain.  Impressive bit
of code.

Applied to the togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
along with the DT bindings.

Thanks for all you hard work on this.

Jonathan
