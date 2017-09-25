Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:45224 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933910AbdIYKZE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 Sep 2017 06:25:04 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 324D820A0C
        for <linux-iio@vger.kernel.org>; Mon, 25 Sep 2017 12:25:03 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 25 Sep 2017 12:25:01 +0200
From: Martin Kepplinger <martink@posteo.de>
To: harinath Nampally <harinath922@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alison Schofield <amsfield22@gmail.com>
Subject: Re: [PATCH 0/3] Refactor event related code
In-Reply-To: <CAAGUq_o68DAm=nf5P770ZuzpjZCtfxneouWu0mRCXE=0wQmpxA@mail.gmail.com>
References: <1506334065-2891-1-git-send-email-harinath922@gmail.com>
 <5d8c841101a35b47aec56cef1b5a3ff1@posteo.de>
 <CAAGUq_o68DAm=nf5P770ZuzpjZCtfxneouWu0mRCXE=0wQmpxA@mail.gmail.com>
Message-ID: <316061dd4135befde8e6fa34d7705108@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 25.09.2017 12:16 schrieb harinath Nampally:
>> First, this is at least v2 of this series. Second, it still seems to 
>> include
>> a 4th unrelated patch.
> ok I was not sure whether to make it v2 as the change was to only cover 
> letter
> and no code changes. But now I know, will send v3 of this series.
> 

as soon as you don't do an exact resend, increment the version number. 
When
reviewers can ignore all previous versions, they instantly know. And for 
the case
we still want to look at everything, you should include a persistent 
revision history
description below the email's --- dashes.

But actually you should have read this and much more in the 
Documentation
directory before sending.
