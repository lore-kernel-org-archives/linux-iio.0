Return-Path: <SRS0=fWjW=6Q=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFEFC3A5A9
	for <linux-iio@archiver.kernel.org>; Sat,  2 May 2020 17:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9531A20775
	for <linux-iio@archiver.kernel.org>; Sat,  2 May 2020 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588441216;
	bh=Z7RtQ13oPBc5GqTHRowhpIGOBMFLG2ZBoIC2QTCYUPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=x0HtfdvS91i55zQX/y3YIQHLBd9mZsDLynNa3UL52XCsEUjxIqu5ibZw2V0/ahYDt
	 Z0X7iyrRMXW+y3aRtUIU7V0QRt/7ctOcH//SW2vsqTau0/jDXGL7xw2tHUGxvzWr/i
	 bETLYpSnfUocceWas6akDbzE5z11CPKKTI0G2N9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgEBRkQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 May 2020 13:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbgEBRkP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 May 2020 13:40:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0A3E206F0;
        Sat,  2 May 2020 17:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588441215;
        bh=Z7RtQ13oPBc5GqTHRowhpIGOBMFLG2ZBoIC2QTCYUPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WJQ5kYLJNus+47H/0vBh9nojTvN+giQgeEtY902zTExwZsRWB50zVQfT0tzmutyt3
         y26lm5IqjPtkerr6pgn6iFFQN6PMlVJmfELnOs6Uhju+k7OVzjco9pbO2gTyDBQ6vT
         BJfLpAJqPVEPynoudKndyFPIo7gJAf9X+vcZx240=
Date:   Sat, 2 May 2020 18:40:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v5 5/6] iio: imu: Add support for adis16475
Message-ID: <20200502184010.134eb8b5@archlinux>
In-Reply-To: <2418ed60-8407-0c99-bf5d-1afc3964de2b@metafoo.de>
References: <20200413082445.17324-1-nuno.sa@analog.com>
        <20200413082445.17324-6-nuno.sa@analog.com>
        <2418ed60-8407-0c99-bf5d-1afc3964de2b@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Apr 2020 20:06:07 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 4/13/20 10:24 AM, Nuno S=C3=A1 wrote:
> > [...]
> > +static irqreturn_t adis16475_trigger_handler(int irq, void *p)
> > +{
> > [...]
> > +	__be16 data[ADIS16475_MAX_SCAN_DATA], *buffer;
> > [...]
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp); =
=20
>=20
> If the timestamp is enabled the IIO core might insert padding between=20
> the data channels and the timestamp. If that happens this will disclose=20
> kernel stack memory to userspace.
>=20
> This needs either a memset(data, 0x00, sizeof(data)) or maybe put data=20
> into the state struct and kzalloc it.

Good spot. Could simply do __be16 data[ADI..] =3D {0}; rather than explicit
memset, but some form of zeroization is needed.

I've fixed up the applied patch with the above approach.

Thanks,

Jonathan

>=20
> - Lars
>=20

