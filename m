Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095632;
	b=jLrl5ncFk4qng/SRXWqiGj2dACHXQdCkz47keR7SxOSclEBNxeeSJVz1oPBMytrcF5f1
	 57F6ZwVS4UX5q2qLL2ksLWOqdRKKshis/dHseE5yLiAS/EfCgODZEeJvHMNZdcAbAdX63
	 FlNIPRkRP7iTcirbNyx//qULRuAQ9fdUTOL9dz8jJwaGEI7gKLCnFkIsag5hHPNzr9g8R
	 MZU4IUNFh6kzYiDxmzv/1ko8nVebumVukB4DoAGSO36f7vLCxzwjpIl1WMeipRPLzdAff
	 6NYyIW5GFetiroSBODCPMsI97QbWQi4DS/2MUub5H9yUvFZVXhofWJfBliXVnXMEtag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095632;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WFbhXnonUMB4MsMDpFD9tXyRvsBkUMaSQV0XLq68nDk=;
	b=pDFA+IPdcXpkMFhVkB8an2NNOShicmFxu5I3+5QfbJYf2/VFfAFZ3BYSBN9W0AFp52N7
	 qdDB9J3Hae1cINJFFtj7Jg0xZUw5M7pI9XIhw3C4qubaacJ7YjD9aPGqmH0WsygzNS41w
	 BaA2fHZlxeZELv1kx0w4T9ZP9KCybDlksQd2nwLsDYK2fVxpwo1ZDuGhG5au9OMBzmjHW
	 Sg1BuA0BISxkaO9+yJ77xgdjHq/6wG37Z5WccGbu7FiQfRBfV3VGg2gCkxjNdEaiokRMj
	 VB1j29UeOXme90V1Cs4pqROkYvrCTskc23InRU95uqNsonFWssqMPOEoGt2HYOg4oqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BRyzq2S/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7C606A326;
	Sat,  7 Nov 2026 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRyzq2S/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A9B1F0089F;
	Sat,  7 Nov 2026 23:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794095631;
	bh=WFbhXnonUMB4MsMDpFD9tXyRvsBkUMaSQV0XLq68nDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BRyzq2S/hsWT2dkTqFE5719cT1bq8K33GBpU2V0HVWwvIxANuQbkqbP+YFjLQsqfP
	 KoJedX7+NjHe4l4wKmb3OveSu1wZ1jbpZxUrPaEq9jLWNN7JVFRnlqP7YSvcvjkcZP
	 372vgkoLo1yTYAsxL8L+ax4oH0iAea6n/yjzN90tMcDw06+OIKMZ769IPqIpzHsfy9
	 gdMhTHRtmWbNGnOLM0q82nCh6xEJyUfEnvQRNPIRZcEE1tj9RypWd0KDwnY51UA9OY
	 ozageyHUfHuwgb0GH5YYAGHgAyY3Q2bJrx0Rg6OzOJqaKGUCdRk8OzFlOaXoC5uSx7
	 RFl9Fc4VkDgVw==
Date: Sat, 7 Nov 2026 23:53:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: light: stk33xx: add power supply
 support
Message-ID: <20261107235342.40f2e45a@jic23-hlaptop>
In-Reply-To: <geNqZOyrIjYLfmuUys8cQJU8FM53jylicArPsTGNXPnqSvHPCIc1Jad7dBOBy1GdE38RBEMSYQYDqEmaAqq2PDcglQcRBdkR0yZAjRExEUQ=@protonmail.com>
References: <20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com>
	<20261108-6768-stk3337-v1-1-0340c99b0e33@protonmail.com>
	<20261107223601.0ba9ffc6@jic23-hlaptop>
	<geNqZOyrIjYLfmuUys8cQJU8FM53jylicArPsTGNXPnqSvHPCIc1Jad7dBOBy1GdE38RBEMSYQYDqEmaAqq2PDcglQcRBdkR0yZAjRExEUQ=@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 07 Nov 2026 22:45:45 +0000
Roman Vivchar <rva333@protonmail.com> wrote:

> Hi Jonathan,
> 
> On Sunday, November 8th, 2026 at 12:36 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sun, 08 Nov 2026 00:15:03 +0200
> > Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:
> >   
> > > From: Roman Vivchar <rva333@protonmail.com>
> > >
> > > On some boards, the chip shares a power rail with other components. If
> > > that rail is turned off, the chip can't function.  
> > Not sure how the sharing is relevant.  Even if shared with nothing
> > else we need to turn it on.  So just mention that on some boards it
> > isn't always on.
> > 
> > The only reason this would be optional in the binding is if there
> > was internal routing in some packaging or similar that meant there
> > was no pin to connect.
> >
> > Upshot, make this required in the binding. Note that doesn't mean
> > the driver must require it - we are simply documenting that the
> > device needs power.
> >   
> 
> I agree this should be required, but that would break dt_binding_check
> for existing boards. I don't have their schematic nor boards themselves
> to verify the regulator for the power supply.

There aren't any upstream (from a quick grep) and so not your problem
unless you have some in a downstream tree that need fixing.
If you do then there is the option of a fixed regulator to close
the gap.  I consider a missing supply a bug that we should fix but maybe
others disagree.

Jonathan


> 
> Best regards,
> Roman

