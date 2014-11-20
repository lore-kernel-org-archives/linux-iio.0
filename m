Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:50140 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbaKTLWA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Nov 2014 06:22:00 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/4] Correct vendor-prefix and document device isl29028
Date: Thu, 20 Nov 2014 12:21:43 +0100
Cc: Darshana Padmadas <darshanapadmadas@gmail.com>,
	devicetree@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	opw-kernel@googlegroups.com
References: <1415467328-9745-1-git-send-email-darshanapadmadas@gmail.com>
In-Reply-To: <1415467328-9745-1-git-send-email-darshanapadmadas@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201411201221.43308.arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Saturday 08 November 2014, Darshana Padmadas wrote:
> Patchset documents correct and the deprecated vendor-prefix found by checkpatch
> warning and also documents information of device isl29028 for compatibility.
> Patchset also includes corrected vendor-prefix and device name in compatible
> property for files with checkpatch warning of undocumented string "isil,isl29028".
> 

Since nobody else has picked these up, I've put them into the arm-soc
tree in the next/dt branch now.

Thanks and sorry for the delay,

	Arnd
