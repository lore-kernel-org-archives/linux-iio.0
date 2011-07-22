Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:42446 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab1GVMFz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jul 2011 08:05:55 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:57969)
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1QkEUM-0006s7-sY (Exim 4.72) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Fri, 22 Jul 2011 13:05:54 +0100
Message-ID: <4E2967A8.5070502@cam.ac.uk>
Date: Fri, 22 Jul 2011 13:06:00 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Temporary git tree for ABI changes etc.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

It's time for another one of those git trees with lots
and lots of warnings attached.

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio-blue.git

I will rebase this and edit the history in response to reviews etc.

If nought else it has a really dirty version of Rusty's simple ida
patch so we'll be replacing that when a final version is decided on.

So, what is currently there...

1) Everything I've sent Greg KH
2) Lots of cleanup
3) Chrdev merge series (updated according to Arnd's suggestions).
4) Removal of multiple event line support.
5) Channel masks -> bitmap conversion to allow for way more channels.
6) 64 bit event code introduction
7) Fixes

Have fun. I'll post the patches for review on list, but feel free
to take a look and in particular test anything you can!

Thanks,

Jonathan
