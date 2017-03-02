Return-Path: <SRS0=zSF+=2L=perches.com=joe@kernel.org>
Message-ID: <1488437696.2179.3.camel@perches.com>
Subject: Re: [PATCH 2/2] HID: Remove unnecessary OOM messages
From: Joe Perches <joe@perches.com>
To: Michel Hermier <michel.hermier@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,  Stefan
 Achatz <erazor_de@users.sourceforge.net>, Jonathan Cameron
 <jic23@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Date: Wed, 01 Mar 2017 22:54:56 -0800
In-Reply-To: <a52260a5-921c-53f9-8709-ae7189395cee@gmail.com>
References: <cover.1488395879.git.joe@perches.com>
	 <0fbe692283802d36df389af7cbda9a4bff44db5e.1488395879.git.joe@perches.com>
	 <a52260a5-921c-53f9-8709-ae7189395cee@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2017-03-02 at 07:51 +0100, Michel Hermier wrote:
> Le 01/03/2017 à 20:19, Joe Perches a écrit :
> > diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
[]
> > @@ -224,7 +224,6 @@ static int asus_start_multitouch(struct hid_device *hdev)
> >   
> >   	if (!dmabuf) {
> >   		ret = -ENOMEM;
> > -		hid_err(hdev, "Asus failed to alloc dma buf: %d\n", ret);
> >   		return ret;
> >   	}
> 
> Trivial set and return value missed.

You're welcome to submit a follow-on patch.

The compiler should produce the same code
in any case.
