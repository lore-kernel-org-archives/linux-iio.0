Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:33523 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbC1NKm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 09:10:42 -0400
Received: by qcbjx9 with SMTP id jx9so37928287qcb.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2015 06:10:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55169AD2.3080400@kernel.org>
References: <cover.1426981797.git.cristina.opriceana@gmail.com>
	<ac0d5b2399b00fe9763c7844c726ffad0a65df99.1426981797.git.cristina.opriceana@gmail.com>
	<55169AD2.3080400@kernel.org>
Date: Sat, 28 Mar 2015 15:10:41 +0200
Message-ID: <CAFA9rWNH8nwSQv75eQMOdxNGgF6bEGOjDCLw5pvdoALUjkh2xA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Staging: iio: Place driver in sleep mode on error
From: Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "outreachy-kernel@googlegroups.com"
	<outreachy-kernel@googlegroups.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Mar 28, 2015 at 2:13 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 22/03/15 00:26, Cristina Opriceana wrote:
>> Put device in sleep mode if an error is encountered after
>> initialization in order to avoid wasting power.
> The patch title should definitely include the name of the driver in question!
> Otherwise you'll not generally get reviews from the relevant people.
> Staging:iio:hmc5843 Place driver in sleep mode on error during probe.
>
> Also try to cc relevant people and the relevant list.
> See MAINTAINERS and you'll notice we have both a list and a
> set of designated reviewers who would like to be cc'd on IIO patches.

Okay, thanks for your feedback, I'll keep that in mind for the future work
because Greg has already merged this on his staging-next branch.

Thanks,
Cristina
