// SONIC ROBO BLAST 2
//-----------------------------------------------------------------------------
// Copyright (C) 1993-1996 by id Software, Inc.
// Copyright (C) 1998-2000 by DooM Legacy Team.
// Copyright (C) 1999-2023 by Sonic Team Junior.
//
// This program is free software distributed under the
// terms of the GNU General Public License, version 2.
// See the 'LICENSE' file for more details.
//-----------------------------------------------------------------------------
/// \file  m_bbox.c
/// \brief bounding boxes

#include "doomtype.h"
#include "m_bbox.h"
/**	\brief	The M_ClearBox function

	\param	box	a fixed_t array of 4 to be cleaned

	\return	void


*/

void M_ClearBox(fixed_t *box)
{
	box[BOXTOP] = box[BOXRIGHT] = INT32_MIN;
	box[BOXBOTTOM] = box[BOXLEFT] = INT32_MAX;
}
/**	\brief	The M_AddToBox function

	\param	box	a fixed_t array of 4 to be added with
	\param	x	x of box
	\param	y	y of box

	\return	void


*/

void M_AddToBox(fixed_t *box, fixed_t x, fixed_t y)
{
	if (x < box[BOXLEFT])
		box[BOXLEFT] = x;
	if (x > box[BOXRIGHT])
		box[BOXRIGHT] = x;

	if (y < box[BOXBOTTOM])
		box[BOXBOTTOM] = y;
	if (y > box[BOXTOP])
		box[BOXTOP] = y;
}
/**	\brief	The M_PointInBox function

	\param	box	a fixed_t array of 4 to be checked with
	\param	x	x of box
	\param	y	y of box

	\return	if it's in the box


*/

boolean M_PointInBox(fixed_t *box, fixed_t x, fixed_t y)
{
	return (x < box[BOXLEFT] || x > box[BOXRIGHT] || y < box[BOXBOTTOM] || y > box[BOXTOP]) ? false : true;
}
/**	\brief	The M_CircleTouchBox function

	\param	box	a parameter of type fixed_t *
	\param	circlex	a parameter of type fixed_t
	\param	circley	a parameter of type fixed_t
	\param	circleradius	a parameter of type fixed_t

	\return	boolean


*/

boolean M_CircleTouchBox(fixed_t *box, fixed_t circlex, fixed_t circley, fixed_t circleradius)
{
	return (box[BOXLEFT] - circleradius > circlex || box[BOXRIGHT] + circleradius < circlex || box[BOXBOTTOM] - circleradius > circley || box[BOXTOP] + circleradius < circley) ? false : true;
}
