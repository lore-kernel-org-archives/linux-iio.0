Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:35168 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891Ab0EELT3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2010 07:19:29 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:43874)
	by ppsw-32.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1O9cdU-0007qF-BD (Exim 4.70) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Wed, 05 May 2010 12:19:28 +0100
Message-ID: <4BE154EB.9070701@cam.ac.uk>
Date: Wed, 05 May 2010 12:22:19 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: iio-abi-new tree scrapped
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear All,

Given the whole contents of the iio-abi-new tree
is now in staging-next and Greg KH also fixed a lot
of sparse warnings and one hidious bug with wrong parameter
ordering in a kzalloc in max1363 *tries not to look too embarassed*.
I have just removed the iio-abi-new tree from kernel.org.

I'll get into the habit of running a recent version of sparse
on my patch sets. One lives and learns. Much thanks is due
to Greg for the fix ups!

Thanks,

Jonathan
