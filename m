Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548153E1221
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058695; cv=pass; b=qzMxnipStjZ7eoLBDVCrxEleCUKEkffaYQ0yVzRTYc6j1OaPeRvPZkjsBHxYeOf8QWEslstELN5Ce90KU0KzWomNEIjT2xm7UgrIShsIwX33D4mutJxKzuTtYReq4bvEzacFvSuKZJKN9e06nbKIb+RSm5+3XXvcu3Bei9hAz/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058695; c=relaxed/simple;
	bh=M4bTXOPZH9eLQiy6ZvaD+nc7ONjW9bp2mJRz7DeWHFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEPDBE8WiHE6cv8Sp8FFxyAYPAMfrfCUVlqyCAQUV8yCui28GBJoEN8QW/Ac2bOJ5f/Pc7crWHKfew0+9qSBJHMdaaUZ5Z02cZsXrpirK7mgafKEKTAJZ5xuAwtXrmGdHRaXYlueB8BTnDjI61mA0NGk7hL+Zjek430Go3CSwwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6nNkuBb; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6nNkuBb"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-132830d8281so1871677c88.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 05:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780058693; cv=none;
        d=google.com; s=arc-20240605;
        b=QOWlCzj2GQsaCoUsxDIBGTO8O0Zw6dn0bmED0F2SnEomKH6BzycOyGRkXISt+CkbCP
         Abn+L3zGyGsqBc2BMQIDT5Ly6dbyAC8BxWGTLGcMPtYUH03igWE6zHUXbjeEsf3VKFqk
         bU/gqrwWztgjSqI8f3yX4JMRQaQ/6rcKZqtlrYPx1msXKRPOu0geavpbd+VJjb8pdkHd
         AA9WDdsHICYEPRmC4UZveKjTAAUbW9VthvJIQ+dmrctg3i1Ok2fbhDBHpY73tKZgMrnY
         khTghtZ7HkH5Y78xueIYrasEoWzbpzo+TtCCsjr7w7U1/VKOdgvzqWyrD9ZHNcdklGpc
         gNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NNMtWPP10CT5p5rrDk2KTLCMwhU3X0sQZPLuXsdc9co=;
        fh=UBjF/oaYi4vC6OARkco+8hEEXBrCV+v5SUUTBWTLU8U=;
        b=R4Pv6Z/s1FgdjxeWQYfmI9JCmSMWbuI9uNNJ8hdPICR+nt6r000l4v5y5XpbSs/Fjf
         +ezPDWxi4bcYGUTsXneTJ4JQoM0wriEVf917NhfHHubS9pYTXIy11tSnC6+j6As9dsJL
         40vj1UfSsG8YZXu1VgRPx6elAFW6mZBVHPRVkRFu4hWqt3ovDY+9+F0+eYfHSItJ4s/H
         TOwUKHxsS1JkALndYeuPOUdnbUc/o/WmKYdphJqEPlRykxVK6nV/nN6DihFnH8Vn+pdC
         k5K9pJl5kN5VBo1LkrzuOZvab2/kIZvQeO69su7mjbora6teLqPHL0ZF5D8XCEPcoMlZ
         +PQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780058693; x=1780663493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NNMtWPP10CT5p5rrDk2KTLCMwhU3X0sQZPLuXsdc9co=;
        b=C6nNkuBbslbrsGvvFCaBCHckOGzeMu8PSRHGKiNk9xpPufpCSSYdlrQs/DsstBuUNe
         t8hUoECWnJK70gVXHR1dFI+TPJoOV3vsDQRrZxUIH7Kuj+k/LD8clZO4qvyWNIFpOquE
         Pkg/4Q/0DZDkMX9SjY+IBlVgxVlqzGzngan5b5vCJ9e6oSvNQMg/OUEQ2enW9QpwCcxY
         lGzUuBhezlVzPm6pigV9M19vnYx59SOkvZNVHMZW8tL+OWVr67Ow26MFb8+f0SO2xykR
         tpF4A6BWQzC5E6XJ5C79ZKkhAPAtIBVBJrDLRYeLTfXpPT9vLehX2o0MuGZQMHYmdkhQ
         h2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780058693; x=1780663493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNMtWPP10CT5p5rrDk2KTLCMwhU3X0sQZPLuXsdc9co=;
        b=WppsHBhL8lQkAhPOnHGtTbmnrxKh15Z5PwRTOaXplMvAg49Mo4iQQqVe0IIoojDY6D
         I6igEwPjny6o91YeqUswEfn56dAyp2Gw0kdj4mRW6HWu1aj+IkpaMWbfMI98CuJbpx2p
         CypDlvCGQxga9MHkNLG8F43EPb4zC13chijk56xWWklrrXqDJJXSAT+zuxuCzWAIYVSN
         ycRgZMiemlNRS/xN5fdfyDHl5y3+1JNSl65nAxjy5ujdKjI1Ot9DXm4GAKk5fNFr6bU2
         W0UbZJWhiPnhq2UA2UVjItgT2QiAER1eLjpfGGa7dqp8JuISOaf82riadfo5i5rcaBrw
         Bykg==
X-Gm-Message-State: AOJu0YyhHL0e7szkMYwczfSate40vni8N9/8ErXrDXeGec/3g9Pdm6NX
	hhoJR1SmW6tr/JZBYJw7kvSq4FFLWdnmyjWFvRT2ClYRDe7czQbQZYO1r2aLqHTMF7bu0kzw/2g
	5mUY57/+iUphawHIm6YdjZ0Vg7woQUis=
X-Gm-Gg: Acq92OF3BDDgR8wUhM2pzheHqQDi+/znspeGo4UIK8PDXjLV73I/nbEZwTN16E7J+MZ
	K9x4/N2NIVt0oZSK6Yk/CoEv/RWwqXSq0EtfRSasbXEBGEmrb2JTo0DaO5vBDs0P80F/HTifhiq
	zu2ToGScD2FDLlLpeY7cUCCBI8KDH9kS2qhiIY1Qw9uI60AE9RnurZchmB02FnJ8NEprwvFceIN
	kCRZHCmYcMlmCi/fz6i03iE+j8rYwKLT1bFvyN5WE6W1olEtXc9AKr2sGEyKutUGfG+VGN4ZDyu
	o162uJ4t1aSuvR1Qei1QHAa09IdVIZyHx9tfFmFCQ0ghlHwkDsgc5W85KNlxB7DpCqpmjtDm1db
	3jqgOYVGCH6sYEwX1
X-Received: by 2002:a05:7300:1493:b0:304:e2a5:689e with SMTP id
 5a478bee46e88-304eb0f1942mr1157086eec.2.1780058693522; Fri, 29 May 2026
 05:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
 <20260524085312.15369-5-kimjinseob88@gmail.com> <20260528145840.0329992c@jic23-huawei>
In-Reply-To: <20260528145840.0329992c@jic23-huawei>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Fri, 29 May 2026 21:44:41 +0900
X-Gm-Features: AVHnY4IcyOp5CZC6i3jxkpOuG2fXWQ5C6S5HEB1G4kbbTEN36elytsTpf7dHQ5o
Message-ID: <CALMSewJnv25V6ivT5RJmUvGVijpOK8YK+6-dcn_RDLUPx8eDsA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/7] iio: osf: add stream parser
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Thu, May 28, 2026 at 10:58:00PM +0100, Jonathan Cameron wrote:
> > Various minor things inline.
>
> Addressed in RFC v3.
>
> I applied the stream parser cleanups in the new series.
>
> >         for (size_t i = 0; i < stream->len; i++)
> >                 match_len = min(stream->len - i, OSF_STREAM_MAGIC_LEN);
>
> Addressed in RFC v3.
>
> >                 if (get_unaligned_le16(stream->buf + 6) != OSF_FRAME_HEADER_LEN) {
> >
> > is fine. We are a bit flexible on line length when it helps readability.
>
> Addressed in RFC v3 where it improved readability.
>
> > As in previous patch, how do we get here with any of those being possible?
> > The last one might make sense as it's about coupling between parameters, but
> > I'm not seeing the first two as useful unless you clear stream->osf in remove
> > path or similar.  If you do maybe a comment.
>
> Addressed in RFC v3. I removed the unnecessary internal-only checks and kept
> the boundary check for the invalid buffer/length relationship.
>
> > No way for first erro to be set, so same as:
> >    return osf_stream_process(stream);
> >
> > If this changes later in this patch series then fine to keep it like this.
>
> Addressed in RFC v3.
>
> >    copy_len = min(len, space);
>
> Addressed in RFC v3.
>
> I also reviewed the Sashiko feedback for this patch while preparing RFC v3.
> Normal chunked reception is no longer counted as an error-style partial frame
> condition, and the stream/core path was kept consistent with the revised
> validation boundary used in the rest of the series.
>
> Thanks,


>
> Jinseob
