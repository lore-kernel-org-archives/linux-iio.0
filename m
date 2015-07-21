Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:36175 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbbGUMOM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2015 08:14:12 -0400
Received: by lagw2 with SMTP id w2so116256658lag.3
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2015 05:14:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEnQRZC7z3ZbR40xnG2UPmVVJ34at8mKS70R5O9h24HNAKQZbQ@mail.gmail.com>
References: <1437473652-29150-1-git-send-email-giuseppe.barba@st.com>
	<55AE264D.8060300@st.com>
	<CAPMRSivehmu204qoZD2hQ7fZedx90PnMLWfPV09TiVettCDosQ@mail.gmail.com>
	<CAEnQRZC7z3ZbR40xnG2UPmVVJ34at8mKS70R5O9h24HNAKQZbQ@mail.gmail.com>
Date: Tue, 21 Jul 2015 14:14:10 +0200
Message-ID: <CAPMRSisPJxrDaXmX8DcQpYsw0Z3LLmD+msaYLX7a7Zoy-JgDfQ@mail.gmail.com>
Subject: Re: [PATCH] iio: st: rework code style removing goto statements
From: Giuseppe Barba <giuseppe.barba@gmail.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe BARBA <giuseppe.barba@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Daniel,

2015-07-21 13:23 GMT+02:00 Daniel Baluta <daniel.baluta@gmail.com>:
> On Tue, Jul 21, 2015 at 2:08 PM, Giuseppe Barba
> <giuseppe.barba@gmail.com> wrote:
>> Hi Denis,
>>
>> thanks for review.
>>>
>>> Just add one blank line please, it was missing also before!
>>>
>>> Denis
>>
>> I'll add the missed blank line and push again the patch to you.
>
> Hi Giuseppe,
>
> Thanks a lot for your work :). One minor nit that could improve
> reviews for your next patches.
>
> Please add modification history from version to version. This can be done
> in the cover letter if you have multiple patches, or in the patch itself under
> the scissor line.
>
> e.g.
> [PATCH V2] iio: st: rework code style removing goto statements
>
> The scope of this patch is to remove some goto statements and its label
> present into st sensors driver.
>
> Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
> --- <this is scissor line>
> Change since v1:
>    * added missing blank lines.
>
> thanks,
> Daniel.


Thanks for your hint.
I'll do that next time.

Regards
Giuseppe.
