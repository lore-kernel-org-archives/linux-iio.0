Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35543 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbbLDEaL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2015 23:30:11 -0500
Received: by lbcdv4 with SMTP id dv4so13694960lbc.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Dec 2015 20:30:09 -0800 (PST)
MIME-Version: 1.0
From: Matt Ranostay <mranostay@gmail.com>
Date: Thu, 3 Dec 2015 20:29:29 -0800
Message-ID: <CAKzfze_t+D1sxP58EJeR284XbLHnrvaLOEpBgq_wdGGg2gW9XA@mail.gmail.com>
Subject: [RFC] pH sensors
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello et all,

So currently planning on working a I2C based pH sensor and want to get
some input on the iio_chan_type to use.

There are two solutions  that can be thought of:

1) Use the current IIO_CONCENTRATION type and use the percentage of
Hydronium (H3O+) in the solution to report to actual pH levels
2) New IIO_PH type that is an typically an integer from 0 (acid) - 14 (base)

Thanks,

Matt
