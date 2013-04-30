Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:61888 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab3D3CYG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 29 Apr 2013 22:24:06 -0400
Received: by mail-vc0-f175.google.com with SMTP id lf10so34463vcb.6
        for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2013 19:24:04 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 30 Apr 2013 04:24:04 +0200
Message-ID: <CAOTW74kb_qJP=by_iKOTCHVurh2wEc6nfmdL-F2ddqq3aQ672g@mail.gmail.com>
Subject: Abstracting and extending evdev to work with the iio subsystem
From: alessandro osima <alex.osima@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Hunyue Yau <hy-gsoc@hy-research.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello everyone, my name is  Alessandro Osima and I'm a computer
science student at Università degli Studi di Milano, Italy (second
year, equivalent to bachelor).


 For this year's Google Summer of Code I have decided to submit an
application proposal focused on abstracting evdev  from input to allow
iio and other subsystems to take advantage of it to send/receive
events and data to userspace application troughout files located in
the /dev directory.

This http://www.google-melange.com/gsoc/proposal/review/google/gsoc2013/asion/1#
 is my proposal.

I would kindly ask your opinions about this project and would be very
grateful for any comments and suggestion to improve it.

Thank you for reading this post and please don't hesitate to ask for
any clarification or more details.

Regards

Alessandro Osima.
