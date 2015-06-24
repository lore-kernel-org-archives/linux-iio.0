Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:41338 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172AbbFXPOy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Jun 2015 11:14:54 -0400
Message-ID: <438f185903eb23358f027ba90e9e980b.squirrel@mungewell.org>
In-Reply-To: <20150624110608.65a31e2a52bb2752352605db@ao2.it>
References: <1435105830-2297-1-git-send-email-simon@mungewell.org>
    <20150624110608.65a31e2a52bb2752352605db@ao2.it>
Date: Wed, 24 Jun 2015 11:14:49 -0400
Subject: Re: [RFC_v2 0/4] HID: hid-sony: Add IIO Suport for Motion
 Controllers
From: simon@mungewell.org
To: "Antonio Ospite" <ao2@ao2.it>
Cc: "Simon Wood" <simon@mungewell.org>, linux-input@vger.kernel.org,
	"Frank Praznik" <frank.praznik@oh.rr.com>,
	linux-iio@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> the SixAxis also have a gyroscope, I don't know how useful/reliable it
> is, but it's there.

I had a recollection that there was a gyro, but didn't see it when looking
at the 'hidraw' stream.

It might be affected by the 'multi-touch axes' bug.
Simon


