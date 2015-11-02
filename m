Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36209 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbbKBRR3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2015 12:17:29 -0500
Received: by igdg1 with SMTP id g1so61712579igd.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2015 09:17:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOMZO5Bc8hotVooOG+sEjtYqb7ENapQ0Fw08a_Y-hRpvLgxwTw@mail.gmail.com>
References: <1427503398-19682-1-git-send-email-abrestic@chromium.org>
	<20150329040053.GD36501@dtor-ws>
	<CAL1qeaFHhPW=eS+CaVC1DZXHL8YausOaR1itc8pwVLTeWyDnMg@mail.gmail.com>
	<CAOMZO5Bc8hotVooOG+sEjtYqb7ENapQ0Fw08a_Y-hRpvLgxwTw@mail.gmail.com>
Date: Mon, 2 Nov 2015 09:17:28 -0800
Message-ID: <CAL1qeaE6Tkge4CR+b0h9f+CipN8De-fhuP=9BbAdagnCxKdGmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: Add binding document for a generic ADC keypad
From: Andrew Bresticker <abrestic@chromium.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Fabio,

On Sun, Nov 1, 2015 at 5:55 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Andrew,
>
> On Mon, Mar 30, 2015 at 1:56 AM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>
>>> I'd rather we have it defined explicitly in the binding, i.e. make it a
>>> required property?
>>
>> Sure, will do.
>
> Do you plan to send a v2 of the generic ADC keypad series?

We ended up not needing this driver, so I didn't send up a v2.

Thanks,
Andrew
