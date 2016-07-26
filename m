Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:10408 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753285AbcGZXfH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 26 Jul 2016 19:35:07 -0400
Date: Wed, 27 Jul 2016 07:35:03 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Alison Schofield <amsfield22@gmail.com>
Cc: lkp@lists.01.org, linux-iio@vger.kernel.org
Subject: Re: [LKP] drivers/iio & kbuild test robot
Message-ID: <20160726233503.GA15811@wfg-t540p.sh.intel.com>
References: <20160726224911.GA16097@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20160726224911.GA16097@d830.WORKGROUP>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Alison,

On Tue, Jul 26, 2016 at 03:49:19PM -0700, Alison Schofield wrote:
>Hi Fengguang,
>
>I recently submitted a patch that adds Kconfig options required
>to build a few drivers in IIO.  The kbuild robot did not find
>these.
>
>You can see the patch here:
>http://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg-post-rc1&id=9b1425b1698cca01887ad154b631b59666882fb5

What're the error messages look like? That'll help me root cause why
they are missed.

>I'd like to get a general understanding of the build testing the robot
>provides the iio subsystem, and then specifically see if these types of test
>cases can be added.

In general for build tests, 100% coverage is our goal. If any error
is missed, it'd be appreciated to inform us and get the gap closed.

- build error/warnings in all kind of kconfigs
- sparse/coccinelle/smatch static checks
- testing patches posted to mailing lists

You may also opt-in to email notifications triggered by git push, so
that you are aware whether the robot is making good progress for each
pushed branch.

>I'm up for digging into this if you'll point me in the right direction.
>
>First off, I hope this is the correct email list - lkp@list.01.org
>I didn't want to get lost in all the robo messages in kbuild-all.

Yeah actually either account will reach us. Yet another one is
lkp@intel.com which has internal forward rules to all 0day team
members. Since I do content based filtering, emails not look like
automated reports will be directed to my main mail box.

Thanks,
Fengguang
