Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-008.synserver.de ([212.40.185.8]:1382 "EHLO
	smtp-out-003.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757237Ab2EOIhT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 May 2012 04:37:19 -0400
Message-ID: <4FB21652.9070809@metafoo.de>
Date: Tue, 15 May 2012 10:39:46 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: IIO include folder hierarchy
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I was just preparing a patch to move the DAC drivers out of staging. And I'm
wondering if we want to use a flat hierarchy in the IIO include folder, i.e
put all includes in toplevel folder. Or if we want individual subfolders for
the different device classes (e.g. include/linux/iio/dac/ in this case). I'd
opt for the later since I fear that things would get quite messy over time
in the toplevel folder.

Thanks,
- Lars
