Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:19093 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbbFXJMZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 24 Jun 2015 05:12:25 -0400
Date: Wed, 24 Jun 2015 11:06:08 +0200
From: Antonio Ospite <ao2@ao2.it>
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org,
	Frank Praznik <frank.praznik@oh.rr.com>,
	linux-iio@vger.kernel.org
Subject: Re: [RFC_v2 0/4] HID: hid-sony: Add IIO Suport for Motion
 Controllers
Message-Id: <20150624110608.65a31e2a52bb2752352605db@ao2.it>
In-Reply-To: <1435105830-2297-1-git-send-email-simon@mungewell.org>
References: <1435105830-2297-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 23 Jun 2015 18:30:26 -0600
Simon Wood <simon@mungewell.org> wrote:

[...]
> The SixAxis contains accelerometers, the DS4 contains accelerometers and gyros.
>

Hi Simon,

the SixAxis also have a gyroscope, I don't know how useful/reliable it
is, but it's there.

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
