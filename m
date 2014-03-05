Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx-relay04-dus.antispameurope.com ([94.100.134.204]:37593 "EHLO
	mx-relay04-dus.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757757AbaCEPLK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 5 Mar 2014 10:11:10 -0500
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: "Lars-Peter Clausen" <lars@metafoo.de>
Subject: Re: [RFC] LIBIIO
Date: Wed, 5 Mar 2014 16:11:05 +0100
Cc: Paul Cercueil <paul.cercueil@analog.com>, linux-iio@vger.kernel.org
References: <53146822.5020602@analog.com> <201403051112.51519.manuel.stahl@iis.fraunhofer.de> <5317354E.9050803@metafoo.de>
In-Reply-To: <5317354E.9050803@metafoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201403051611.05139.manuel.stahl@iis.fraunhofer.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am Mittwoch, 5. März 2014, 15:31:42 schrieb Lars-Peter Clausen:
> On 03/05/2014 11:12 AM, Manuel Stahl wrote:
> > Hi Paul,
> >
> > I didn't read all of your text (will do later), but would like to point out that there is alreay a project going on here:
> > http://sourceforge.net/projects/iioutils/
> 
> Well, the iioutils lib is extremely low level. It is basically just a bunch 
> of fprintfs and fscanfs. The libiio has a more high level abstraction build 
> in. The basic structure of the libiio is the iio_context, it is a (to the 
> user transparent) struct that is used for all operations (E.g. like 
> get_devices()). If an application wants to do something it first allocates a 
> context, there can be multiple contexts per application and each contexts 
> tracks is own state, so there is no globally shared state. Each context has 
> a backed. One backend is the local backend that performs all operations on 
> device the application is running on. But there is also a network backend 
> that connects to a sever running on a different device. This allows to run 
> the same application on local and remote the devices without the application 
> having to have any special code for supporting this.
> 
> There is also a IIO daemon that can sit between the application and the IIO 
> sysfs. This daemon allows for multiple applications accessing the same 
> device without trampling over each others feet and also allows to run the 
> application without root rights.
> 
> My hopes are that the libiio can eventually replace the iio-utils lib.

That's also what I hope for. But we should try to avoid name clashes. The lib in iioutils is also called libiio. So I propose to merge the repositories somehow.

Regards,
Manuel
