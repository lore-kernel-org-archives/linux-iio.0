Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vn0-f52.google.com ([209.85.216.52]:34380 "EHLO
	mail-vn0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964992AbbGVOzy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2015 10:55:54 -0400
Received: by vnds125 with SMTP id s125so49073371vnd.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2015 07:55:53 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 23 Jul 2015 00:55:53 +1000
Message-ID: <CA+0Dg4qeAvTJ1EJFqN4=eJ3X9qecP8yPhvBBvUs-pYqP08i3jA@mail.gmail.com>
Subject: iio_utils tool incorrectly assumes "offset" file to be present
From: Joo Aun Saw <jasaw@dius.com.au>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I'm new to this mailing list and I'm new to IIO, so please forgive me
if I ask silly questions. I haven't got time follow the latest
development in IIO.

I'm using iio_utils tool in my program and noticed build_channel_array
function assumes "offset" file to be present under the IIO device. The
issue is, not all IIO devices provide an "offset" file. I'm using ST
accel, magn, and gyro drivers, and there's no "offset" file. Is offset
supposed to be optional?


Joo.
