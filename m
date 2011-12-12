Return-Path: <Johannes.Tenschert@informatik.stud.uni-erlangen.de>
From: Johannes Tenschert <Johannes.Tenschert@informatik.stud.uni-erlangen.de>
To: devel@linuxdriverproject.org
Cc: jic23@cam.ac.uk,
	gregkh@suse.de,
	jbrenner@taosinc.com,
	linux-iio@vger.kernel.org
Subject: staging: iio: light: obsolete use of strict_strtoul v2
Date: Tue, 13 Dec 2011 00:38:20 +0100
Message-Id: <1323733102-7868-1-git-send-email-Johannes.Tenschert@informatik.stud.uni-erlangen.de>
List-ID: <linux-iio@vger.kernel.org>

Hi,

I changed the patch to use the right kstrto* as Dan Carpenter suggested, but
I'm not familiar enough with the code to fix the divide by zero bug in a good
way.

I also didn't change taos_settings because I don't know it well enough and don't
want to introduce new bugs. So kstrtoint was used provisional to set it.
