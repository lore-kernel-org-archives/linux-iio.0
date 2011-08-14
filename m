Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:58040 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab1HNUVU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Aug 2011 16:21:20 -0400
Received: by pzk37 with SMTP id 37so2015295pzk.1
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2011 13:21:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1313353117-25140-1-git-send-email-pthomas8589@gmail.com>
References: <1313353117-25140-1-git-send-email-pthomas8589@gmail.com>
Date: Sun, 14 Aug 2011 13:21:19 -0700
Message-ID: <CAD56B7ebEtMQ+KimCZgYGNf-JCHo_0itW7FNNEAUctBoEuxa+Q@mail.gmail.com>
Subject: Re: [PATCH] iio: [v2] add support for Analog Devices ad7194 a/d converter
From: Paul Thomas <pthomas8589@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk, Paul Thomas <pthomas8589@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

OK, so this used the iio_chan_spec now. I just did 1 attribute for the
gain instead of 1 / channel. It's always set before the query anyway
so there's no reason for it to be per channel.

thanks,
Paul
