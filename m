Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462838E8A6;
	Tue,  4 Aug 2026 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884190; cv=none; b=MNEwN9f2kUrBA1IXMgbvCYpLmLTUTZHS8H6jaw/k1iwukfG2qys0LwEWgd6Cr0pvR+1W8BxcDGw5SCrgHCSc8P+30QQrqrQwtMt+vPjaERp9LPzfRzPCNPhqdhKzzdrKuZuBGvP1+XzUYiNDCcbafF9vUJwpSoHnSPhZAg6IZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884190; c=relaxed/simple;
	bh=HwEWBiWNvOg2+I0kjediFZfV23Mqw65H//AeWcDz6t0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7Z6m6q7Qu3HW+qBsOiENQpSK2bPYcNEFLiOzQFmN9/jA1m67A/o15W/uMRIoTbZjpVnws64xZj1eZeIbFsItgT1YQMvtZ+VGtvcd5WiXYniUibTV/BbIyCooChG72ukRZFR1NV4qs227OpAvXFeXbdDiTxvGv4vm7zf5Umc7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1sqPd8t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1sqPd8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D311F000E9;
	Tue,  4 Aug 2026 22:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785884189;
	bh=uU0dSKLT/noqQ0p29ypKWERSOQYt7DTrIufkx3aPXsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e1sqPd8txZEWoLUSn2pT0EMNOqb5x2/MnBH+xaHSq6MnWRpLuLfqdjEnbPxs4afl5
	 iyBuI6bKJySRKigFAqgGbH4NWFNNd9XZvvjEZ3n8TUTak6W2cpUJ8HMnIAGiDjqcu5
	 MKm3AKVeY5KfCPVdfWPWZS5GznbOsa49Wsi4lf46glqat4iJJ3dNEvkSllcRrgspPt
	 Lpf9iWW9+NUKwr4sVGOcGET8J0RFVWaLZRboGCHdb7gtVFpwkVsD3RgFRHT82qLHRc
	 n2/hCkUnUw34M2vivGipKzIIe2VbVLu6mPFhh+lIf0TPVa2MjFE6UmJYcyc3iauDT7
	 CPcA+bXkSO4pg==
Date: Tue, 4 Aug 2026 23:56:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nikita Travkin" <nikita@trvn.ru>, "Maslov Dmitry" <maslovdmitry@seeed.cc>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
Message-ID: <20260804235622.06dd567a@jic23-huawei>
In-Reply-To: <87ldamar80.fsf@geanix.com>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-2-d18af55edab5@geanix.com>
	<20260716-adept-kraken-of-calibration-cddebc@quoll>
	<pnxaJvFlsLehHV30SMlmWECZnbQ6Rqb2cvWWlVbjYKsg9v0i_Wyu28e7U_OYfV1XooewL13ZLUMBjODBTYnBuiI0t9m-bxt8AdKsz9oizok=@geanix.com>
	<9Ekqt5M10zvl-oDffITzNkebHtnMwG2Z_kIEqGL-cokgqKRyNyFxqCB5wZZelUe9dEO9EWhjqt59zBsqU7jMbg==@protonmail.internalid>
	<20260719023830.5f99d335@jic23-huawei>
	<87ldamar80.fsf@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 04 Aug 2026 16:35:27 +0200
Esben Haabendal <esben@geanix.com> wrote:

> "Jonathan Cameron" <jonathan.cameron@oss.qualcomm.com> writes:
> 
> > On Thu, 16 Jul 2026 16:14:55 +0000
> > Esben Haabendal <esben@geanix.com> wrote:
> >  
> >> On Thursday, 16 July 2026 at 10:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>  
> >> > On Wed, Jul 15, 2026 at 02:27:24PM +0200, Esben Haabendal wrote:  
> >> > > LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
> >> > > without interrupt support.
> >> > >
> >> > > Signed-off-by: Esben Haabendal <esben@geanix.com>
> >> > > ---
> >> > >  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
> >> > >  1 file changed, 1 insertion(+)
> >> > >
> >> > > diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> >> > > index ab9bb68dd736..76e81eba7ea4 100644
> >> > > --- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> >> > > +++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> >> > > @@ -19,6 +19,7 @@ properties:
> >> > >        - liteon,ltr559
> >> > >        - liteon,ltr301
> >> > >        - liteon,ltr303
> >> > > +      - liteon,ltr329  
> >> >
> >> > Do not grow lists at the end, they are ordered alphanumerically to avoid
> >> > conflicts.  
> >>
> >> Placing the new entry at the top would produce a rather strangely order list:
> >>
> >> ltr329
> >> ltr501
> >> ltr559
> >> ltr301
> >> ltr329
> >>
> >> Should I add a patch sorting the entire list to avoid this kind of
> >> confusion in the future?  
> >
> > Please do a precursor patch for that  Also do it for the id tables in the driver.  
> 
> Ok. Sorting ltr501_id and ltr501_of_match should be trivial.
> But what about ltr501_chip_info_tbl (and the anonymous enum used to
> index it, should they be sorted as well? And ltr301 being 0 instead of
> ltr501, the original device the driver was written for?
Sure. The numbers don't mean anything in particular afterall.

Good point to raise.

Jonathan

> 
> /Esben
> 

