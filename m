Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34423 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933264AbbFWVST (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Jun 2015 17:18:19 -0400
Received: by wgqq4 with SMTP id q4so20318003wgq.1
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2015 14:18:18 -0700 (PDT)
MIME-Version: 1.0
From: Jeremy Trimble <jeremy.trimble@gmail.com>
Date: Tue, 23 Jun 2015 17:17:58 -0400
Message-ID: <CAHYiM2+6wVqLsJTkBqXkumQRp272TMd7SYq4APnHDRDVu2CMGA@mail.gmail.com>
Subject: iio: Multiple iio_buffer per device
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello all.

I've got some custom hardware that provides data in response to an
explicit request (or stream of such requests).  I'd like to use
iio_buffer to catch the data that is returned .  However, I'd also
like multiple users (i.e. multiple openers of the device) to be able
to be able to send requests to the device and each receive the results
into their own separate buffer.

I've implemented a system like this in the past through ad-hoc use of
mmap(), wrote my own userspace buffer interaction library (a la
libiio), and allowing requests to be submitted through ioctl().
However, I'd like to use iio_buffer here if possible, as it is more
widely-supported than my own one-off solution.

Are there any instances of multiple buffers being associated with an
IIO device (or such buffers being created on-the-fly)?  Has this kind
of idea ever been discussed before?

Thanks.
-Jeremy Trimble
