Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55473AD50B
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618916; cv=none; b=qvqn5SDIJY5vkT/k1nbOSY9NC1TdF080mlKhIp69Q467LJV/+/+7HbK9YhR0TxRvydusmkWd/eVf+HliOyU5ZtDWjNHDFz8MYeFAM+90StENG8wTv3q4ae1Dppq8tQ4kV4x+1YvCJEBNyM1q7wRR9a37fKoM+km9YQB8Rgm9bkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618916; c=relaxed/simple;
	bh=SnEqL8Lj+FRSND8lqI+U43QtslizUAkSD7EWX7nfnTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLN0axNaSCYj0F+MMVmk5BiGRAhH7WI1gFu/uGUfJzxFrsbL7swFvZjLiNp6tQ3AvKpxUoiapc9e86DTkSAFLFh1RblvHVhcFraT/FS+xjwD5QL6BFNCTamxAVRGk9Y72wiAqsXktqE/qr+FAO5TfEGWaI3sTwVFo6MMfum1/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayDhd3e7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayDhd3e7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F18C2BCC7
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 20:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778618915;
	bh=SnEqL8Lj+FRSND8lqI+U43QtslizUAkSD7EWX7nfnTk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ayDhd3e7En3J4BRTfMsjiTG6p9YldApBdJ2kr662KQO4zvNY8rW6X1YZSG0DIdRC+
	 Y7OdGmSSJ539k16mw/OfKv3zVSciTGRhQfxPIcJjG241e/CnTNIwY756Bb/+AJDj80
	 ZrimwhNkRr10/w4WZ4oworajAmSMGRsaF9z90145dInmUgHItMFU6muT8C6gH1Bx5s
	 N9c/y88MS160vcXKjR/Jr7K4U+cica6EmgeenYFSICBBmRVa+SGNDAo9mWB+oCdtt6
	 flzJMNtYrC2WO9DRaoGnSyHGj6RE+0IHZMqfO9KL96VhF9zpYuWaBQ7vqYJufwo945
	 +lkKFw8Y9Eq0A==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67e9e343b22so7419498a12.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 13:48:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/LbSzLqp9AWbSXqrS6GXhhyidzlorcmymG5N0HxpWC5yTkOem9xDT+S/dpooC2RYJff6xeI/IsnZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqFPX9iaIGleqvGOzCWiTXB0sVWo2rmS5t9C7N77C6NrvAn92
	AZLsXo2Z80u8uM6hW0IHKiMp6m3wV/XmNKqdtHfW1RU0nzUON8V7hQiLKKPc5CVqSqCmFbLXlkf
	Wt/vqsy7r0XM/8vfoXD1E1/CAU1Rlxw==
X-Received: by 2002:a05:6402:3059:b0:670:9ca8:1eb4 with SMTP id
 4fb4d7f45d1cf-68255bf8040mr175415a12.12.1778618914126; Tue, 12 May 2026
 13:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
 <20260510120141.118057-1-pramod.nexgen@gmail.com> <20260511171554.6541042b@jic23-huawei>
 <7baf9ca5-50ff-4131-995b-70ee094ed247@baylibre.com> <CAL_JsqLxtWLR+jxRXt7Uz6dcF-90NYmfyGWYQk9um9TYHSWbTw@mail.gmail.com>
 <a4ecfb27-5ef4-4682-b87c-24917f81b4f0@baylibre.com> <CAL_JsqKP-C-rA6_19vtMzevVxQiD7bH=k5ObEZZDM3-Zmr_vtg@mail.gmail.com>
 <5a02550a-a578-4c0b-a8b0-2056f0248478@baylibre.com>
In-Reply-To: <5a02550a-a578-4c0b-a8b0-2056f0248478@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 May 2026 15:48:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ1qD_3UE2FD5Pgme1yhSDLuGYYj3brfMJsmotSmNNhuw@mail.gmail.com>
X-Gm-Features: AVHnY4JJAw3XA4xxqmQ2OyiF2Jg8Lwk1xyuoOr4v_YxirGxOoDE-30WV7bPgDT0
Message-ID: <CAL_JsqJ1qD_3UE2FD5Pgme1yhSDLuGYYj3brfMJsmotSmNNhuw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: iio: adc: Convert xilinx-xadc bindings to
 YAML schema
To: David Lechner <dlechner@baylibre.com>
Cc: Pramod Maurya <pramod.nexgen@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:03=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 5/12/26 2:42 PM, Rob Herring wrote:
> > On Tue, May 12, 2026 at 8:58=E2=80=AFAM David Lechner <dlechner@baylibr=
e.com> wrote:
> >>
> >> On 5/12/26 7:14 AM, Rob Herring wrote:
> >>> On Mon, May 11, 2026 at 11:24=E2=80=AFAM David Lechner <dlechner@bayl=
ibre.com> wrote:
> >>>>
> >>>> On 5/11/26 11:15 AM, Jonathan Cameron wrote:
> >>>>> On Sun, 10 May 2026 08:01:36 -0400
> >>>>> Pramod Maurya <pramod.nexgen@gmail.com> wrote:
> >>>>>
> >>>>>> Convert the Xilinx XADC and UltraScale System Monitor device tree =
binding
> >>>>>> from the legacy plain-text format to a YAML schema, enabling autom=
ated
> >>>>>> validation with dt-schema.
> >>>>>>
> >>>>>> The new binding covers the same hardware and compatible strings:
> >>>>>>   - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
> >>>>>>   - xlnx,axi-xadc-1.00.a  (AXI softmacro)
> >>>>>>   - xlnx,system-management-wiz-1.3 (UltraScale System Management W=
izard)
> >>>>>>
> >>>>>> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
> >>>>> Hi Pramod,
> >>>>>
> >>>>> Something went wrong with your sending of v3. I have two versions s=
ent
> >>>>> half a day apart and no idea how they are related.
> >>>>>
> >>>>> Anyhow one of them got feedback from Rob's bot so I'll assume we ar=
e
> >>>>> getting a v4 and wait for that.
> >>>>>
> >>>>> Jonathan
> >>>>
> >>>> I think Rob will have to fix the bot to make an exception for the
> >>>> legacy bindings. This should have been called out in the commit mess=
age
> >>>> as requested in a previous revision.
> >>>
> >>> The bot is not the problem. It just runs validation. The schemas will
> >>> have to either drop this check (comma's in nodenames) or exclude just
> >>> this property.
> >>>
> >>>
> >>> Rob
> >>
> >> Even though this is an existing text-based schema that has been around
> >> for 12 years with this name already? Changing it could be a breaking
> >> change to existing users. Although there aren't any in any .dts in the
> >> kernel source.
> >
> > I'm absolutely not suggesting changing the node name.
> >
> > The common schemas globally disallow commas in nodenames. We can relax
> > that and allow commas in any nodename. That check is largely from
> > QCom's amazingly consistent use of 'qcom' prefix in nodenames. We've
> > finally beat that practice out of them. So maybe it's not needed
> > anymore.
> >
> > The other approach is to exclude this nodename and any other we have
> > to keep. I don't like dtschema having to know about some random name,
> > but we already have that in a few cases and I don't expect that list
> > to be too long given this is the first case we've seen.
> >
> > Rob
>
> Got it. So when I said "fix the bot" earlier, I should have said
> "fix dtschema". We went through this before with adi,channels, but
> I didn't remember exactly what you did.

Completely forgot that. That makes picking which one easy...

> I created a pull request for dt-schema [1] for this since it was
> easier than trying to explain it for someone else to do.
>
> [1]: https://github.com/devicetree-org/dt-schema/pull/195

Thank you! Applied.

Rob
