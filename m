Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:32817 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbbE3Gyx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 May 2015 02:54:53 -0400
Received: by pdbqa5 with SMTP id qa5so69226603pdb.0
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2015 23:54:52 -0700 (PDT)
Date: Sat, 30 May 2015 12:24:42 +0530
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
Cc: jic23@kernel.org, daniel.baluta@intel.com,
	dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, linux-iio@vger.kernel.org,
	driverdev-devel@linuxdriverproject.org
Subject: Re: [PATCH v2 2/3] staging: iio_simple_dummy: fix return types
Message-ID: <20150530065442.GG31685@sudip-PC>
References: <1432935923-28928-1-git-send-email-rodriguez.twister@gmail.com>
 <1432935923-28928-3-git-send-email-rodriguez.twister@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1432935923-28928-3-git-send-email-rodriguez.twister@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, May 30, 2015 at 12:45:22AM +0300, Vladimirs Ambrosovs wrote:
> The functions iio_dummy_remove(), iio_simple_dummy_events_unregister() and
> iio_dummy_evgen_release_irq() were changed to return void instead of int, 
> because these functions always return 0.
> 
> Signed-off-by: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
oops. it breaks the build.

drivers/staging/iio/iio_simple_dummy_events.c:260:6: error: conflicting types for ‘iio_simple_dummy_events_unregister’
In file included from drivers/staging/iio/iio_simple_dummy_events.c:18:0:
drivers/staging/iio/iio_simple_dummy.h:82:5: note: previous declaration of ‘iio_simple_dummy_events_unregister’ was here

drivers/staging/iio/iio_dummy_evgen.c:131:6: error: conflicting types for ‘iio_dummy_evgen_release_irq’
In file included from drivers/staging/iio/iio_dummy_evgen.c:24:0:
drivers/staging/iio/iio_dummy_evgen.h:11:5: note: previous declaration of ‘iio_dummy_evgen_release_irq’ was here

drivers/staging/iio/iio_dummy_evgen.c:137:1: error: conflicting types for ‘iio_dummy_evgen_release_irq’
In file included from drivers/staging/iio/iio_dummy_evgen.c:24:0:
drivers/staging/iio/iio_dummy_evgen.h:11:5: note: previous declaration of ‘iio_dummy_evgen_release_irq’ was here

regards
sudip
