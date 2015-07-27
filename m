Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vn0-f49.google.com ([209.85.216.49]:35787 "EHLO
	mail-vn0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbbG0EVv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 00:21:51 -0400
Received: by vnaa140 with SMTP id a140so26686406vna.2
        for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2015 21:21:50 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 27 Jul 2015 14:21:50 +1000
Message-ID: <CA+0Dg4o_D-U-=z=4FwC=aWe0CGH+wHPe1tqrDQudR1n89bBByg@mail.gmail.com>
Subject: iio_utils.c defines _IIO_UTILS_H
From: Joo Aun Saw <jasaw@dius.com.au>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

What is the purpose of having ifndef _IIO_UTILS_H and define
_IIO_UTILS_H at the top of iio_utils.c file? Is this a copy and paste
error from the original iio_utils.h file?


Joo.
