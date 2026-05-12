Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CC9368D40
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614952; cv=none; b=DfxXBYkZLArKDW5DevLD7p2gOqWwJBpe/TAvLqF7ZbWS+SVa06sHHGF7sY6oG1P3qzxXV6IfDJMoBs8AucaKTXXFgm6WoFPGMJQRAh+wXSQbeXI4sGqaw7262jvdfHeavB5FDpPeqKduaUr/GboIHgymVMkpbH6GHh1jXSzW6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614952; c=relaxed/simple;
	bh=/jUE21Fh0ZBgRkBMfVEV7iY3fmhHPWdJdPHALN9c0dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GM531ztA62sXyMjn+v3f0aHSL/W1w5Ulx3vp9QXOrIHY3bL9BJBgLvYYs6umXNbysAh+znT5Krpy753HfDmNa2vS59/qIUkIt7yx9TzfEFPiw1cjt82PWtkob2mnG53vD/JaKyXsOZtXZDEVMpZFO5ert6MtbF49sShvvWRtPLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3hMbMMm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3hMbMMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8853C2BD00
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 19:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778614951;
	bh=/jUE21Fh0ZBgRkBMfVEV7iY3fmhHPWdJdPHALN9c0dE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J3hMbMMm0IjKGUPkOzhvyrdpEOnB/2QSYZ8sXskwbJizIVdDegNePibeHnrQPIcVQ
	 5J+JRfUK6RSs09qyme7L2q7XeTDX9x6/laiQ7P934MhjaaXThMOIDo/JAaK/bWIXrH
	 DzH7+UFa2AH8gJ9F8DH6RBiqO7T7SgXFT0fz0PKDn5peMQFkZZyE6YH1OFzB34XBFI
	 LR9U8LAwLNz1/iJYprqEC6rZIG2aLiDzjpVsWyhPyVnjvCINCOPWKwsUiZx/enpgL5
	 5NHjvEDciVxNOpFASCNiTkvSA5IYSWoTbCTaBj30WsFWaRTIO/UFHFb+RTvWoJRzIT
	 /F0lMpLoDxqEQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so10081283a12.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 12:42:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/uDNFjOgbAkA3WF+/gM5k3Pa7zj1Ljq5zoWaXq/30MXCxU1dnBQCUnO2cIo1VuCw49C+wATGX6diQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZWrw9ht7KtC2klRrXo4Qb5RgWW828YxLc63Das2Th6y4CYEgE
	GdOD4QI/F9nDA0cRI8M0UpCY39p4kLq9LDt9HZLmtwQg8myxaIDVsnDC1pENZQj3bf459HEUlKr
	XVUNxbZX9cMLInsILiclum9vOiuZqyg==
X-Received: by 2002:aa7:dd0f:0:b0:67c:7697:1ee8 with SMTP id
 4fb4d7f45d1cf-682557ef49amr91032a12.5.1778614950379; Tue, 12 May 2026
 12:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
 <20260510120141.118057-1-pramod.nexgen@gmail.com> <20260511171554.6541042b@jic23-huawei>
 <7baf9ca5-50ff-4131-995b-70ee094ed247@baylibre.com> <CAL_JsqLxtWLR+jxRXt7Uz6dcF-90NYmfyGWYQk9um9TYHSWbTw@mail.gmail.com>
 <a4ecfb27-5ef4-4682-b87c-24917f81b4f0@baylibre.com>
In-Reply-To: <a4ecfb27-5ef4-4682-b87c-24917f81b4f0@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 May 2026 14:42:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKP-C-rA6_19vtMzevVxQiD7bH=k5ObEZZDM3-Zmr_vtg@mail.gmail.com>
X-Gm-Features: AVHnY4LNwO7x3BIsFrr8Vj4o4zwD7AK9d1BcRjayQvl2V-UTQfrTo4IgojWNqkc
Message-ID: <CAL_JsqKP-C-rA6_19vtMzevVxQiD7bH=k5ObEZZDM3-Zmr_vtg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: iio: adc: Convert xilinx-xadc bindings to
 YAML schema
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Pramod Maurya <pramod.nexgen@gmail.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 8:58=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 5/12/26 7:14 AM, Rob Herring wrote:
> > On Mon, May 11, 2026 at 11:24=E2=80=AFAM David Lechner <dlechner@baylib=
re.com> wrote:
> >>
> >> On 5/11/26 11:15 AM, Jonathan Cameron wrote:
> >>> On Sun, 10 May 2026 08:01:36 -0400
> >>> Pramod Maurya <pramod.nexgen@gmail.com> wrote:
> >>>
> >>>> Convert the Xilinx XADC and UltraScale System Monitor device tree bi=
nding
> >>>> from the legacy plain-text format to a YAML schema, enabling automat=
ed
> >>>> validation with dt-schema.
> >>>>
> >>>> The new binding covers the same hardware and compatible strings:
> >>>>   - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
> >>>>   - xlnx,axi-xadc-1.00.a  (AXI softmacro)
> >>>>   - xlnx,system-management-wiz-1.3 (UltraScale System Management Wiz=
ard)
> >>>>
> >>>> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
> >>> Hi Pramod,
> >>>
> >>> Something went wrong with your sending of v3. I have two versions sen=
t
> >>> half a day apart and no idea how they are related.
> >>>
> >>> Anyhow one of them got feedback from Rob's bot so I'll assume we are
> >>> getting a v4 and wait for that.
> >>>
> >>> Jonathan
> >>
> >> I think Rob will have to fix the bot to make an exception for the
> >> legacy bindings. This should have been called out in the commit messag=
e
> >> as requested in a previous revision.
> >
> > The bot is not the problem. It just runs validation. The schemas will
> > have to either drop this check (comma's in nodenames) or exclude just
> > this property.
> >
> >
> > Rob
>
> Even though this is an existing text-based schema that has been around
> for 12 years with this name already? Changing it could be a breaking
> change to existing users. Although there aren't any in any .dts in the
> kernel source.

I'm absolutely not suggesting changing the node name.

The common schemas globally disallow commas in nodenames. We can relax
that and allow commas in any nodename. That check is largely from
QCom's amazingly consistent use of 'qcom' prefix in nodenames. We've
finally beat that practice out of them. So maybe it's not needed
anymore.

The other approach is to exclude this nodename and any other we have
to keep. I don't like dtschema having to know about some random name,
but we already have that in a few cases and I don't expect that list
to be too long given this is the first case we've seen.

Rob
