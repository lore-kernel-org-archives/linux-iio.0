Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:43659 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757240AbaFYRA6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Jun 2014 13:00:58 -0400
Received: by mail-ob0-f180.google.com with SMTP id vb8so2454017obc.11
        for <linux-iio@vger.kernel.org>; Wed, 25 Jun 2014 10:00:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHfPSqAAWFtCQQrKBhLFuE2OuO_fwmUOhcOX9zKk8eMRMNSVvg@mail.gmail.com>
References: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
	<1403612356-23685-5-git-send-email-ch.naveen@samsung.com>
	<CAD=FV=Wmi73S4c5TPUqnNyycQ5xX5SbYy_ES-cbbJF2Hr0tqvQ@mail.gmail.com>
	<CAHfPSqAAWFtCQQrKBhLFuE2OuO_fwmUOhcOX9zKk8eMRMNSVvg@mail.gmail.com>
Date: Wed, 25 Jun 2014 10:00:57 -0700
Message-ID: <CAD=FV=VnHZY3vC6y3B-3xXMnYCV+UVrCcgT5y73FJEuKdot_Sw@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: DTS: Add NTC thermistor nodes as child nodes to ADC
From: Doug Anderson <dianders@chromium.org>
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	linux-iio <linux-iio@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"cpgs ." <cpgs@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Tushar Behera <tushar.b@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Naveen,

On Tue, Jun 24, 2014 at 10:04 PM, Naveen Krishna Ch
<naveenkrishna.ch@gmail.com> wrote:
> Also, we have few similar nodes on Peach PI  and Peach PIT.
> Any plans or discussion on merging the common nodes ?

There was some discussion about this in another thread with Javier.
We were thinking of doing more "config fragments" like I did for the
keyboard.  See <https://lkml.org/lkml/2014/6/24/337> for context.

If someone wants to try to break some config fragments out feel free
to send up patches.  Until that is done let's at least keep pit and pi
as close to the same as possible (try to add features to both and try
to make sure that "diff" between the two looks good).

-Doug
