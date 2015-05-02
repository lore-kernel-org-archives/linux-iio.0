Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35030 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbEBPzz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 May 2015 11:55:55 -0400
Received: by widdi4 with SMTP id di4so79856560wid.0
        for <linux-iio@vger.kernel.org>; Sat, 02 May 2015 08:55:54 -0700 (PDT)
Message-ID: <5544F388.8050006@gmail.com>
Date: Sat, 02 May 2015 18:55:52 +0300
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Rhyland Klein <rklein@nvidia.com>, linux-iio@vger.kernel.org
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com
Subject: Re: [PATCH v2 3/3] staging: iio: light: isl29018: Use standard sysfs
 attributes for scale and integration time
References: <1429212059-13010-1-git-send-email-roberta.dobrescu@gmail.com> <1429212059-13010-4-git-send-email-roberta.dobrescu@gmail.com> <553D41CC.6070702@kernel.org> <553E5DEE.5020001@nvidia.com> <5544AED5.1080903@kernel.org>
In-Reply-To: <5544AED5.1080903@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02.05.2015 14:02, Jonathan Cameron wrote:
> I missed a small issue with some missing brackets in one of the switch statements.
> The autobuilder caught it as a formatting issue:
> drivers/staging/iio/light/isl29018.c:373:3-4: code aligned with following code on line 377.
> I'll send out  a patch in a mo, but as it's trivial am happy to apply it without an ack.
>
> note this isn't actually a bug due to the check being strictly unnecessary anyway, but
> it is clearly not as intended!

Oops. Thanks for fixing this, Jonathan!

Roberta
