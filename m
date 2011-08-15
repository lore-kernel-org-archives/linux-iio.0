Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37143 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751113Ab1HOVD7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2011 17:03:59 -0400
Date: Mon, 15 Aug 2011 22:07:28 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jonathan Kunkee <jonathan.kunkee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFC] Moving magnetometer HMC6352 into IIO subsystem
Message-ID: <20110815220728.62f27e35@lxorguk.ukuu.org.uk>
In-Reply-To: <CAGRJchidA8ZTMcJnmfJpoBjjpG1zYFC4XQT8KKxjQUm4o3CCng@mail.gmail.com>
References: <CAGRJchidA8ZTMcJnmfJpoBjjpG1zYFC4XQT8KKxjQUm4o3CCng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Should the HMC6352 digital compass driver (drivers/misc/hmc6352.c)
> be moved under the IIO subsystem (drivers/staging/iio/magnetometer)?

No - that would be a regression .. but read on

> Magnetometers act as ADCs and can have high sampling rates and
> complex internals, so I think that according to
> drivers/staging/iio/Documentation/overview.txt they should almost always
> land in IIO land.

IIO is a staging project that may never go anywhere - some of us are
using magnetometers in product so this alone isn't an answer that works
right now.

> I would be willing to work on the change as I want to submit a similar
> driver for the HMC6343 magnetometer/accelerometer as well.

It would be great if it got added into the IIO subystem *as well*, and in
time when and if IIO goes out of staging it would then eventually replace
the existing drivers.

Alan
