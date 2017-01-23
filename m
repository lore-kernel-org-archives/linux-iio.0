Return-Path: <SRS0=QST6=ZF=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v8 12/12] mux: support simplified bindings for single-user
 gpio mux
To: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
 <1484755035-25927-13-git-send-email-peda@axentia.se>
 <33b29f7e-3e48-b85d-ccf9-93b1d67ac634@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
From: Peter Rosin <peda@axentia.se>
Message-ID: <d32f335f-56f2-38c1-e4d9-4629926dbe21@axentia.se>
Date: Mon, 23 Jan 2017 11:24:18 +0100
MIME-Version: 1.0
In-Reply-To: <33b29f7e-3e48-b85d-ccf9-93b1d67ac634@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 2017-01-22 14:30, Jonathan Cameron wrote:
> On 18/01/17 15:57, Peter Rosin wrote:
>> Allow bindings for a GPIO controlled mux to be specified in the
>> mux consumer node.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> Code is good as far as I am concerned. Only question is whether this

Hmmm, now that I think some more about it, the code supporting the
simplified binding (patch 12/12) is a bit fishy in one respect.

A driver that calls mux_control_get and gets a mux_control that happens
to be backed by an implicit mux chip (i.e. using the simplified binding)
will not be able to reverse the resource allocation with less than a
complete destruction of itself. Now, this is likely not a problem in
most cases, but I bet it will creep up at the most inopportune time. And
your remark that I'm the one that has to maintain this makes me dislike
this concept...

I.e. mux_control_put *should* reverse mux_control_get, but this simply
does not happen for the implicit mux chips, as implicit mux chips are
not put away until the owning device is put away.

Every time I have tried to come up with a way to implement the simplified
bindings I seem to hit one of these subtleties.

> is worth the hassle given the normal bindings don't give that high
> a burden in complexity!

I am missing an ack from Rob though.

> I don't really care either way:)

But Rob seems to care, this series just has to find a way to get out of
his too-much-churn-will-look-at-it-later list. I sadly don't know how to
pull that trick...

Cheers,
peda
