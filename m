Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D677351C20
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778269837; cv=pass; b=XIwIlGZTpsceaXJiqRHoEu0FKL0kcyQxdglCJBvK+BsxS2g4c2wjC/VnIMtOsocMMLTwIYwyprfQd4m5c6oD5LznaKZTyr9YMhAaJBPseJ5Gk0ogFkznaS0yAwVNTJTFhZO9gaeDvEqOIgkfaTGFUvXT+YaOOrytnIb/x11X+oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778269837; c=relaxed/simple;
	bh=LugZ/1vKHHUnXhAsVJ/5OClrtogGkPWYncytNzdGxt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWeok8ODnllBr5XwgL0h6qO6ckdhGBQZap5ckF8OLFm8HyQm265O6BTkJaCjiuc65LKk2Qt67zMhGPjoLvge444tYM+k3eCZKHzKlPAovR3zA9aLucuVfCcOZg4AD0IP3rk5lUgQi+vptmV+XF0Hn+rx4cQsRdf5qvXYvWGy6JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a22m9TO/; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a22m9TO/"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-656d749109cso1440741d50.3
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 12:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778269835; cv=none;
        d=google.com; s=arc-20240605;
        b=kvzpg3vZvq2DmznqYPCUblndCYwVA1fTQ75O8BtTHVcDJ7nsm0y4feUO14cEPGHPXP
         a4308fGPNxDDBFR2CXnD3FcRzw/DoEXARa2Ii/yrjS3GC6bS/kdUb+rE6/MnqId2QV7P
         MEWu6nMGVIMwYL1L/1+cPE0DfCJTitalzNnl1yW18ebfUW2Yd2qN7M69aMZKDZ7veywc
         47sQT5g8xuvD1fxkjMXcXVC3lP9RigcPT3YJkDzRqUEK4GY3LesyckqmT5srUCpDpI3u
         ljZaEdKYGDX7y/EqxtDZeyvu2W0tAtId4Lx0C318LD5m/ENxa0SzRM+IvOYIdLLsg9vZ
         dWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LugZ/1vKHHUnXhAsVJ/5OClrtogGkPWYncytNzdGxt0=;
        fh=Di5MqL89NVC2yTXeFAo9rOttabHfeIQi4BPIOhHTd3U=;
        b=lZRLX4CDrmIEsvZoPI8vpmm9phYKKpJOd2CrEWcE02r/ng/K19LzHnD0Wa8gIXdiK1
         gIBN/4tcraCRzge3S5xBZWctX4VdOwDzxaSbK9BvU/GZ68OCDUAVl2kLuzKgjnYsxwp6
         DD74ATUiZuyPwVMIv8CfUwQCiChcXOhajqYqGCLLbNgpraDWAgut24fK4ZMiJ0JIHpxf
         FUPeD1esTBuKnNQruGZ59qAuuw+n2au79lBnTD/15uFkX/0t2uVMy88Au6VCwuKIdsrf
         BU5tiPe/REqpYQC23RTUxaZZ+BNCn14AOMqwLCeBsK1Jan8RzWerOXLu5X2ty7XVEbIf
         5xog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778269835; x=1778874635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LugZ/1vKHHUnXhAsVJ/5OClrtogGkPWYncytNzdGxt0=;
        b=a22m9TO/+0hK++N8lOfmgdJSPS+1R0C7nJ2R/K/bfDEKL5a4BS+dAScdzfQClWDcfo
         j3g1uuoyn8fwezf9suLnwxjqFg878NLben5SwuIP2kjLRj7rEKUvJDKFmz9aultZmAT4
         UhVXv7NJDmkFwOB4Hp6AzNQymKnslD4Gt6OQueECAgRMZKnWmC922f75/McPnzTzvsFA
         Zk/EO/TylVQmgs0ttzZnzymzS7oxqDXYWkYnmundzG5vIsTzcra2Y7O3WTaS4x946phO
         yGW+0lCCzJyASfloeNVs85qb42gOdkbsVnwH7uJBVdzH8QN6QrmPwDZt+TeGsucApk5L
         lKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778269835; x=1778874635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LugZ/1vKHHUnXhAsVJ/5OClrtogGkPWYncytNzdGxt0=;
        b=L8PiNgjsngOlMt74HKAq5hIHObmo38jTvX18aiEkoPq8zfkyxhFlFyqOusUOMelkEX
         0h3vrWaKNa2plnWcAPk074/MhCkGsO654ivssQv2tWIarzV8S7rxVkh33sz5g62UIJGc
         nftXE7iIw32YE8gxgaDXEt0eT3N+Am9OGS4atXR31nL2KsRlysSYP/MGaLNl2QZDnF7l
         wsRkUyzWfTs5u5lQTNq4Q/Ih70RvJIa5cIivF1mfg5WiW+9nA9z+1PHiS1SmPayKAmYQ
         0EpF+2R6ShN3AuTbmWivJ6tMRfzTKbLzfRr/clJHDgozkL01LaKzukkzmOBFypKeEBRq
         6XdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/AlsTSZGA570PuNkuDKsHd9MhX3R+4wJlIILLjCkgMEKdU7iJhF/PsODkZBtQSwCPsCxdcFLTJcKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKNj22YbNkLlCjKkWEoHdtkX0M1O5Wrkt712G/2elvT7etHcs
	IrSQOTXqrjPpsAHilXemSLmPwRx8MKWHQzTdzXbutjgW/t65ZPaCK+Cx1cLtc+aYjgr6HQZvJcS
	GZ/PRD/79fnrl+s+YGgW93JapYNWVOVM=
X-Gm-Gg: Acq92OEQejM6ditB5pTdst6rQMVGl0k3J//BZSlKLexwLjGYl7hTWaEy8s0irI5yGTz
	op+aSjgmEEKocZ19iDHjxRXG1tGwHCQJ8AnOa2HEkQZEzUOTcVXHeCW7KBjAniP/NTA61bki0aK
	P1s6m6lJ2HIGCRNpXDTS+9kq8bVTqBcHW+DZ8RXVaAcYAd1ghVNzbyK4hgeCyvLN7YRuU6O5N4j
	+fhvm8vnN1Lz1T40lq5+nmu8uvGD6cIXiU1cBBPlruHNoDJXQwgApM56nKWBTH3w8/GDYDCTAh8
	Teh4DEXjbg==
X-Received: by 2002:a05:690e:1914:b0:65c:654d:3d2e with SMTP id
 956f58d0204a3-65c7999417emr14751997d50.41.1778269835046; Fri, 08 May 2026
 12:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DIDF7CF01QK0.38MS3JFMU6RPL@gmail.com> <20260508181612.11176-1-sozdayvek@gmail.com>
In-Reply-To: <20260508181612.11176-1-sozdayvek@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 8 May 2026 14:50:24 -0500
X-Gm-Features: AVHnY4KfQbmGMqzLvYpEoEF8sOKcWGb_UCfCkdKNGr3MLBIbldqP2kBhjE0XbNw
Message-ID: <CAKqfh0FEm0Ys7m+vdvaV7qavj86tm7HKf+pFN6-DD=T8HKR1ag@mail.gmail.com>
Subject: Re: [PATCH v2] iio: chemical: scd30: reject (response=NULL, size>0)
 in scd30_i2c_command()
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 2:16=E2=80=AFPM Stepan Ionichev <sozdayvek@gmail.com=
> wrote:
>
> On Fri, 08 May 2026, Maxwell Doose wrote:
> > I guess we're still handling the cases where both response/rsp and
> > size are zero here below?
> >
> > Should add a comment showing that this handles this case but that's
> > just my personal nit. Not worth forcing a v3 so
> >
> > Acked-by: Maxwell Doose <m32285159@gmail.com>
>
> Thanks for the ack and the review!
>
> You're right -- the (NULL, 0) write-command path is still handled
> correctly by the existing rsp-NULL branch below; the new check only
> rejects the genuinely buggy (NULL, size>0) combination. Happy to add
> a short comment making that intent explicit if Jonathan would prefer
> a v3, otherwise I'll keep it noted for a future cleanup.
>

BTW, if Jonathan asks you to resend for some other technical issue,
please add that comment. Otherwise if he doesn't ask for v3 or doesn't
include it himself, don't bother. Also, keep in mind that "Acked-by !=3D
Reviewed-by". Just means the patch is appropriate for inclusion.

best regards,
max
