Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58763 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396Ab1CON6j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2011 09:58:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] Add STMicroelectronics LPS001WP pressure sensor device driver into misc
Date: Tue, 15 Mar 2011 14:58:31 +0100
Cc: Guenter Roeck <guenter.roeck@ericsson.com>,
	Jean Delvare <khali@linux-fr.org>,
	mems applications <mems.applications@st.com>,
	"rdunlap@xenotime.net" <rdunlap@xenotime.net>,
	"carmine.iascone@st.com" <carmine.iascone@st.com>,
	"matteo.dameno@st.com" <matteo.dameno@st.com>,
	"rubini@ipvvis.unipv.it" <rubini@cvml.unipv.it>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1300128906-1066-1-git-send-email-matteo.dameno@st.com> <201103151024.26436.arnd@arndb.de> <4D7F4DBA.1060502@cam.ac.uk>
In-Reply-To: <4D7F4DBA.1060502@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103151458.31390.arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tuesday 15 March 2011, Jonathan Cameron wrote:
> Interfaces (well sysfs ones anyway) is an area we have hammered pretty hard.
> Arnd, if I you do have time to look at anything, take a look at the abi docs
> in drivers/staging/iio/Documentation/ (mainly sysfs-bus-iio).
 
Ok, I'll have a look.

	Arnd
