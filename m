Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACD3E7BCC
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854148; cv=none; b=gYg7+eHPxnDHbFFjzmRTKDaZu/QVX+GY8zsqQS5/DZAt6kbLm4T3IhnyTpSqJHCf+cOc/DRrpaSkU3C/1CBrWvprsyIjfHXG+MR1qMBW/nJNz2LpiHttEa42GFzlloCPQ4t5SfzHsjeIdbzVD+7idfwStpCWpGzMKFrGgAcQ1Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854148; c=relaxed/simple;
	bh=klPzKzrG3VbkJnJUHINxPqEMDHhiQvV/o/b3ZahuIrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W7cONFfQuR0+/2foGBG9F1ZjlPfc7UuT8M7bTDTjP+pAChgL3bE88h3BsglPw80RB9oOH0K+6Haez2c5JHEE/jrSvTk9qZVSBpVpvolmdhXD0FEkR3cxkU3zbOIntBIyK3dkzpWCKR52if1BOLypPPDmeDYiO/HMizX27qifY1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Kl01eEYG; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Kl01eEYG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785854133; x=1786113333;
	bh=89HwBQw+GSLg6utOGg8Ydnn1rVuwDCSYF9R+2PaebFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Kl01eEYG7Cg8mqEfsQyBekxDBv1/bQTCWwP7yaM1uaXnv4JPRVoT6q+wFhy22trQH
	 FPXPQePyxMz6sPHjaEQ404mtHUzdN2GD2XYKdjGq0iq3ezUS8nn+tLr3xqxNA22gK9
	 MJPKzGmmhaDVOlKnZ9YrEQixF6Pcl3Cm7eCKIK9YvNSStw6tt50kQ9fJoGSxr7axq7
	 S7tJDiqRuDC5YtP1BMHqcp6dJSeCz/pDMdeOpzIOf3v9L3wlxP37JTrP7hhBU3lKHS
	 7jqpUDrDVFq4m8qw1xBACIwt8OMJMBlkUh8n+gokNYQhyuFCvW4zW2NtPklG2b8C/k
	 ReFTw+hD27jOw==
X-Pm-Submission-Id: 4hDx0c2CrRz2Scps
From: Esben Haabendal <esben@geanix.com>
To: "Jonathan Cameron" <jonathan.cameron@oss.qualcomm.com>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Nikita Travkin" <nikita@trvn.ru>,  "Maslov Dmitry"
 <maslovdmitry@seeed.cc>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
In-Reply-To: <20260719023830.5f99d335@jic23-huawei> (Jonathan Cameron's
	message of "Sun, 19 Jul 2026 02:38:41 +0100")
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-2-d18af55edab5@geanix.com>
	<20260716-adept-kraken-of-calibration-cddebc@quoll>
	<pnxaJvFlsLehHV30SMlmWECZnbQ6Rqb2cvWWlVbjYKsg9v0i_Wyu28e7U_OYfV1XooewL13ZLUMBjODBTYnBuiI0t9m-bxt8AdKsz9oizok=@geanix.com>
	<9Ekqt5M10zvl-oDffITzNkebHtnMwG2Z_kIEqGL-cokgqKRyNyFxqCB5wZZelUe9dEO9EWhjqt59zBsqU7jMbg==@protonmail.internalid>
	<20260719023830.5f99d335@jic23-huawei>
Date: Tue, 04 Aug 2026 16:35:27 +0200
Message-ID: <87ldamar80.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jonathan.cameron@oss.qualcomm.com> writes:

> On Thu, 16 Jul 2026 16:14:55 +0000
> Esben Haabendal <esben@geanix.com> wrote:
>
>> On Thursday, 16 July 2026 at 10:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> > On Wed, Jul 15, 2026 at 02:27:24PM +0200, Esben Haabendal wrote:
>> > > LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
>> > > without interrupt support.
>> > >
>> > > Signed-off-by: Esben Haabendal <esben@geanix.com>
>> > > ---
>> > >  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
>> > >  1 file changed, 1 insertion(+)
>> > >
>> > > diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
>> > > index ab9bb68dd736..76e81eba7ea4 100644
>> > > --- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
>> > > +++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
>> > > @@ -19,6 +19,7 @@ properties:
>> > >        - liteon,ltr559
>> > >        - liteon,ltr301
>> > >        - liteon,ltr303
>> > > +      - liteon,ltr329
>> >
>> > Do not grow lists at the end, they are ordered alphanumerically to avoid
>> > conflicts.
>>
>> Placing the new entry at the top would produce a rather strangely order list:
>>
>> ltr329
>> ltr501
>> ltr559
>> ltr301
>> ltr329
>>
>> Should I add a patch sorting the entire list to avoid this kind of
>> confusion in the future?
>
> Please do a precursor patch for that  Also do it for the id tables in the driver.

Ok. Sorting ltr501_id and ltr501_of_match should be trivial.
But what about ltr501_chip_info_tbl (and the anonymous enum used to
index it, should they be sorted as well? And ltr301 being 0 instead of
ltr501, the original device the driver was written for?

/Esben
