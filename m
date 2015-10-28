Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35977 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352AbbJ1F07 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Oct 2015 01:26:59 -0400
Received: by lbjm5 with SMTP id m5so744689lbj.3
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2015 22:26:57 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 27 Oct 2015 22:26:57 -0700
Message-ID: <CAKzfze8JuNGf4NEZJxP0X3UQ21FubYgyB8da7FQSv_dK9cuk8Q@mail.gmail.com>
Subject: generic_buffer.c bug
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan et all,

Well actually this issues is in the build_channel_array function
located in iio_utils.c, but when testing my LIDAR driver with the
generic_buffer tool I found the following corner case.

So in_distance_* has a scale entry but no offset so it in turn it
fails.. at line 495 in iio_utils.c

Thanks,

Matt
